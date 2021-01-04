import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faQuestionCircle } from '@fortawesome/free-solid-svg-icons';

import HighlightTextComponent from '../common/HighlightText';
import { sentence2array } from '../utils/util';
import Task from '../models/Task';
import WordContent from '../models/Word';
import 'candidates/styles/components/markwords.scss';

type Word = {
  id: number;
  words: Array<WordContent>;
};

type Props = {
  task: Task;
};

type State = {
  words: Array<Word>;
  isResultScreen: boolean;
};

export default class MarkWordsComponent extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);

    this.state = {
      isResultScreen: false,
      words: this.props.task.taskItems.map(item => ({
        id: item.id,
        words: sentence2array(
          item.context.statement ? item.context.statement.replace(/\*/g, '') : ''
        )
      }))
    };
  }

  handleSubmit = () => {
    const { words } = this.state;
    const firstWords = words[0]['words'];
    firstWords[3]['state'] = 2;
    this.setState({
      isResultScreen: true,
      words: [...words]
    });
  };

  handleKeyDown = (event: React.KeyboardEvent<HTMLSpanElement>) => {
    if (event.keyCode === 13 || event.keyCode === 32) {
      this.handleSubmit();
    }
  };

  render() {
    const { task } = this.props;
    const { name, introduction, instruction, taskItems } = task;
    const { words } = this.state;

    return (
      <div className={'task-container'}>
        <h2 className={'title'}>
          {name}
          <FontAwesomeIcon
            className={'tooltip'}
            icon={faQuestionCircle}
            title={instruction}
            size={'xs'}
          />
        </h2>
        <hr />
        <div className={'items-container'}>
          <h4>{introduction}</h4>
          {taskItems.map((item, index) => (
            <HighlightTextComponent
              key={item.id}
              words={words[index].words}
              isResultScreen={this.state.isResultScreen}
            />
          ))}
        </div>
        <div className={'text-center pt-4'}>
          <button
            className={'btn btn-submit bg-blue white'}
            onClick={this.handleSubmit}
            onKeyDown={this.handleKeyDown}
          >
            Continue
          </button>
        </div>
      </div>
    );
  }
}
