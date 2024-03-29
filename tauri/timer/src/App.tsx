import React, { useEffect, useState } from 'react';
import { FaPause, FaPlay } from 'react-icons/fa';
import { v4 as uuidv4 } from 'uuid';

import {
  isPermissionGranted,
  requestPermission,
} from '@tauri-apps/api/notification';

import { invoke } from '@tauri-apps/api';
import { Event, listen, UnlistenFn } from '@tauri-apps/api/event';
import { timerEvent } from './protocol';
import { fmtDuration, fmtTime, parseDuration, refineDuration } from './util';

function App() {
  const [durationString, setDurationString] = useState('30');
  const [remain, setRemain] = useState(0);
  const [running, setRunning] = useState(false);
  const [endAt, setEndAt] = useState<Date>(new Date(0));

  // simply check for notification permission on startup.
  // the actual notification will be done in the Rust side.
  useEffect(() => {
    const check = async () => {
      let permissionGranted = await isPermissionGranted();
      if (!permissionGranted) {
        const permission = await requestPermission();
        permissionGranted = permission === 'granted';
      }
      return permissionGranted;
    };
    check();
  }, []);

  useEffect(() => {
    if (!running) {
      const rem = Math.floor(parseDuration(durationString));
      setRemain(rem);
    }
  }, [durationString]);

  useEffect(() => {
    if (!running) {
      return;
    }

    let unlisten: UnlistenFn;
    const listenerId = uuidv4();
    const setup = async () => {
      unlisten = await listen(
        timerEvent,
        (e: Event<{ seconds: number; id: String }>) => {
          const id = e.payload.id;
          if (id != listenerId) {
            return; // don't handle it
          }

          const rem = e.payload.seconds;
          setRemain(rem);
          if (rem === 0) {
            setRunning(false);
          }
        },
      );

      await invoke('start_countdown', {
        seconds: remain,
        total: refineDuration(durationString),
        id: listenerId,
      });
    };

    setup();
    return () => {
      unlisten();
      invoke('stop_countdown', { id: listenerId }).then();
    };
  }, [running]);

  const timeVisual = fmtDuration(remain);

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

  const start = async () => {
    let nextRemain = remain;

    if (nextRemain === 0) {
      nextRemain = parseDuration(durationString);
      setRemain(parseDuration(durationString));
    }

    if (!running) {
      const now = new Date();
      const endTime = now.getTime() + nextRemain * 1000;
      const end = new Date(endTime);
      console.log('start: ', new Date());
      console.log('end: ', end);
      setEndAt(end);
    }

    setRunning(!running);
  };

  const onKeyDown = (e: React.KeyboardEvent) => {
    if (e.key != 'Enter') {
      return;
    }

    e.preventDefault();
    setRemain(parseDuration(durationString));
    start();
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

      <button
        className={'bg-blue-500 focus:bg-blue-700 rounded-lg p-1 w-full'}
        onClick={start}
      >
        <div className="flex justify-center items-center pl-2">
          {running ? <FaPause /> : <FaPlay />}
          <span className={'flex-grow'}>{startButtonText}</span>
        </div>
      </button>

      <div
        className="
        grid grid-cols-8 gap-1 items-stretch
        justify-center text-7xl font-digit text-right"
      >
        {[...timeVisual].map((c, i) => (
          <div key={i}>{c}</div>
        ))}
      </div>
      <div className="font-mono text-sm">
        {endAt.getTime() == 0 ? (
          'Enter duration and press Start'
        ) : (
          <>
            {running ? 'Timer will end at' : 'Finished at'}
            <time dateTime={endAt.toLocaleString()}> {fmtTime(endAt)} </time>
          </>
        )}
      </div>
    </div>
  );
}

export default App;
