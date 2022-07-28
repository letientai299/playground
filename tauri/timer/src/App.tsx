import React, { useEffect, useState } from 'react';
import parse from 'parse-duration';
import { FaPause, FaPlay, FaUndo } from 'react-icons/fa';
import {
  isPermissionGranted,
  requestPermission,
  sendNotification,
} from '@tauri-apps/api/notification';

const timerFinishedSound = new Audio('/noti.mp3');

const leftPad2 = (n: Number) => ('' + n).padStart(2, '0');

function refineDuration(s: string) {
  if (!s.endsWith('s') && !s.endsWith('h') && !s.endsWith('m')) {
    s += 's';
  }
  return s;
}

const parseDuration = (s: string) => {
  s = refineDuration(s);
  return parse(s) / 1000;
};

function notify(duration: string) {
  duration = refineDuration(duration);
  sendNotification({
    title: 'Timer',
    body: `Timer of ${duration} finished`,
  });
}

function App() {
  const [durationString, setDurationString] = useState('30m');
  const [remain, setRemain] = useState(0);
  const [running, setRunning] = useState(false);
  const [canNotify, setCanNotify] = useState(false);

  useEffect(() => {
    const check = async () => {
      console.log('call one');
      let permissionGranted = await isPermissionGranted();
      if (!permissionGranted) {
        const permission = await requestPermission();
        permissionGranted = permission === 'granted';
      }
      return permissionGranted;
    };
    check().then((ok) => setCanNotify(ok));
  }, []);

  useEffect(() => {
    if (!running) {
      const rem = Math.floor(parseDuration(durationString));
      setRemain(rem);
    }
  }, [durationString]);

  function finish() {
    setRunning(false);
    if (canNotify) {
      notify(durationString);
    }
    timerFinishedSound.play().then();
  }

  useEffect(() => {
    if (!running) {
      return;
    }

    const id = setInterval(() => {
      setRemain((v) => {
        if (v > 0) {
          return v - 1;
        }

        finish();
        return 0;
      });
    }, 1000);

    return () => clearInterval(id);
  }, [running]);

  const hour = Math.floor(remain / 3600);
  const minute = Math.floor((remain - hour * 3600) / 60);
  const second = remain - hour * 3600 - minute * 60;
  const timeVisual = `${leftPad2(hour)}:${leftPad2(minute)}:${leftPad2(
    second,
  )}`;

  let startButtonText: string;
  if (running) {
    startButtonText = 'Pause';
  } else if (parseDuration(durationString) === remain) {
    startButtonText = 'Start';
  } else if (remain === 0) {
    startButtonText = 'Restart';
  } else {
    startButtonText = 'Continue';
  }

  const start = () => {
    if (remain === 0) {
      reset();
    }

    setRunning(!running);
  };

  const reset = () => setRemain(parseDuration(durationString));

  const onKeyDown = (e: React.KeyboardEvent) => {
    if (e.key != 'Enter') {
      return;
    }

    e.preventDefault();
    setRemain(parseDuration(durationString));
    setRunning(true);
  };

  return (
    <div
      className="
      dark:bg-slate-900
      dark:text-white
      flex gap-2 flex-col items-center justify-center w-full h-full text-2xl p-8
    "
    >
      <input
        type="text"
        className="
          dark:bg-slate-100
          dark:text-slate-800
          border-blue-300
          border-2
          focus:bg-white
          text-center rounded-lg w-full p-1"
        placeholder="Duration: 10m, 30s, ..."
        autoFocus
        value={durationString}
        onChange={(e) => setDurationString(e.target.value)}
        onKeyDown={onKeyDown}
      />

      <div className="grid grid-cols-2 gap-1 w-full justify-center text-white">
        <button
          className={'bg-blue-500 focus:bg-blue-700 rounded-lg p-1'}
          onClick={start}
        >
          <div className="flex justify-center items-center pl-2">
            {running ? <FaPause /> : <FaPlay />}
            <span className={'flex-grow'}>{startButtonText}</span>
          </div>
        </button>

        <button
          className={'bg-orange-500 focus:bg-orange-700 rounded-lg p-1'}
          onClick={reset}
        >
          <div className="flex justify-center items-center pl-2">
            <FaUndo />
            <span className={'flex-grow'}>Reset</span>
          </div>
        </button>
      </div>

      <div
        className="
        grid grid-cols-8 gap-1 items-stretch
        justify-center text-7xl font-digit text-right"
      >
        {[...timeVisual].map((c, i) => (
          <div key={i}>{c}</div>
        ))}
      </div>
    </div>
  );
}

export default App;
