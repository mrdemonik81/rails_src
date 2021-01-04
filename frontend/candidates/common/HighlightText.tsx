import React from 'react';

import WordComponent from './Word';
import '../styles/common/highlighttext.scss';
import Word from '../models/Word';

type Props = {
  words: Array<Word>;
  isResultScreen: boolean;
};

type State = {
  marked: Array<number>;
  isResultScreen: boolean;
};

export default class HighlightTextComponent extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      marked: [],
      isResultScreen: props.isResultScreen
    };
  }

  handleSwitchState = (index: number, state: number) => {
    const { marked } = this.state;
    if (state === 0 && marked.findIndex(el => el === index) >= 0) {
      marked.splice(marked.findIndex(el => el === index));
    } else if (state === 1 && marked.findIndex(el => el === index) < 0) {
      marked.push(index);
    }

    this.setState({
      marked: [...marked]
    });
  };

  componentWillUpdate(nextProps: Readonly<Props>): void {
    if (nextProps.isResultScreen !== this.state.isResultScreen) {
      this.setState({ isResultScreen: nextProps.isResultScreen });
    }
  }

  render() {
    const { words } = this.props;
    return (
      <p>
        {words.map((word, index) => (
          <WordComponent
            key={index}
            word={word}
            isResultScreen={this.state.isResultScreen}
            handleSwitchState={state => this.handleSwitchState(index, state)}
          />
        ))}
      </p>
    );
  }
}
