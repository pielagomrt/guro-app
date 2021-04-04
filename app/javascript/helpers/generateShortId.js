export default function generateShortId() {
  let firstPart = (Math.random() * 466569) | 0;
  let secondPart = (Math.random() * 466569) | 0;
  firstPart = ("000" + firstPart.toString(36)).slice(-5);
  secondPart = ("000" + secondPart.toString(36)).slice(-5);
  return firstPart + secondPart;
}
