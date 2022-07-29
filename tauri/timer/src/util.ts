import parse from 'parse-duration';
import { sendNotification } from '@tauri-apps/api/notification';

export function fmtDuration(remain: number) {
  const hour = Math.floor(remain / 3600);
  const minute = Math.floor((remain - hour * 3600) / 60);
  const second = remain - hour * 3600 - minute * 60;
  return `${leftPad2(hour)}:${leftPad2(minute)}:${leftPad2(second)}`;
}

const leftPad2 = (n: Number) => ('' + n).padStart(2, '0');

export function refineDuration(s: string) {
  if (!s.endsWith('s') && !s.endsWith('h') && !s.endsWith('m')) {
    s += 's';
  }
  return s;
}

export const parseDuration = (s: string) => {
  s = refineDuration(s);
  return parse(s) / 1000;
};

export function notify(duration: string) {
  duration = refineDuration(duration);
  sendNotification({
    title: 'Timer',
    body: `Timer of ${duration} finished`,
  });
}
