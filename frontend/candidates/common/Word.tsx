import React from 'react';

import Word from '../models/Word';

type Props = {
  word: Word;
  isResultScreen: boolean;
  handleSwitchState: (state: number) => any;
};

type State = {
  word: Word;
};

export default class WordComponent extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);

    this.state = {
      word: props.word
    };
  }

  componentWillUpdate(nextProps: Readonly<Props>): void {
    if (nextProps.isResultScreen && this.state.word.state !== nextProps.word.state) {
      this.setState({
        word: {
          ...this.state.word,
          state: nextProps.word.state
        }
      });
    }
  }

  handleHighlight = () => {
    if (!this.props.isResultScreen) {
      const { word } = this.state;
      const { handleSwitchState } = this.props;
      const state = word.state === 0 ? 1 : 0;
      this.setState({
        word: {
          ...word,
          state
        }
      });
      handleSwitchState(state);
    }
  };

  handleKeyDown = (event: React.KeyboardEvent<HTMLSpanElement>) => {
    if (event.keyCode === 13 || event.keyCode === 32) {
      this.handleHighlight();
    }
  };

  render() {
    const { word } = this.state;
    const { state, word: wordItem } = word;
    return (
      <span
        role={'button'}
        tabIndex={0}
        className={`word ${state === 0 ? '' : state === 1 ? ' true' : ' false'}`}
        onClick={this.handleHighlight}
        onKeyDown={this.handleKeyDown}
      >
        {wordItem}
      </span>
    );
  }
}
