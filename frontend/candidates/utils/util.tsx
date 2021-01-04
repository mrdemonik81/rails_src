import Word from '../models/Word';

export const sentence2array = (sentence: string): Array<Word> => {
  const pattern = new RegExp(/[A-Za-z0-9]/);
  const characters = sentence.split('');
  const words = [];
  let tmpStr = characters[0];
  for (let i = 1; i < characters.length; i++) {
    if (pattern.test(characters[i - 1]) && pattern.test(characters[i])) {
      tmpStr += characters[i];
    } else if (pattern.test(characters[i - 1])) {
      words.push({
        word: tmpStr,
        state: 0
      });
      words.push({
        word: characters[i],
        state: 0
      });
      tmpStr = '';
    } else if (pattern.test(characters[i])) {
      tmpStr = characters[i];
    } else {
      words.push({
        word: characters[i],
        state: 0
      });
      tmpStr = '';
    }
  }
  return words;
};
