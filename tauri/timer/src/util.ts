import parse from 'parse-duration';

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

export const fmtTime = (d: Date) => {
  const h = d.getHours();
  const m = d.getMinutes();
  const s = d.getSeconds();
  return `${leftPad2(h)}:${leftPad2(m)}:${leftPad2(s)}`;
}
