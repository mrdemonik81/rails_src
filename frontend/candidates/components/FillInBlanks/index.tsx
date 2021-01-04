import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faQuestionCircle } from '@fortawesome/free-solid-svg-icons';

import Task from '../../models/Task';
import TaskItem from '../../models/TaskItem';

import './index.scss';

type Word = {
  [key: number]: string;
};

type Answer = {
  [key: string]: Word;
};

type Props = {
  task: Task;
};

type State = {
  answer: Answer;
};

export default class FillInBlanks extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      answer: {}
    };
  }

  handleInputAnswer = (
    event: React.ChangeEvent<HTMLInputElement>,
    itemId: number,
    index: number
  ) => {
    const { answer } = this.state;

    this.setState({
      answer: {
        ...answer,
        [itemId]: {
          ...answer[itemId],
          [index]: event.target.value
        }
      }
    });
  };

  renderTaskItem = (item: TaskItem) => {
    const { context: { question = '' } = {} } = item;
    const questionBlocks = question.split('**');
    const { answer = {} } = this.state;

    return (
      <>
        {questionBlocks.map((block, index) => (
          <React.Fragment key={index}>
            {block}
            {index !== questionBlocks.length - 1 && (
              <>
                {` `}
                <input
                  type="text"
                  value={
                    answer[item.id]
                      ? answer[item.id][index]
                        ? answer[item.id][index]
                        : ''
                      : ''
                  }
                  onChange={event => this.handleInputAnswer(event, item.id, index)}
                  className={'input-answer'}
                />
                {` `}
              </>
            )}
          </React.Fragment>
        ))}
      </>
    );
  };

  render() {
    const { task } = this.props;
    const { name, instruction, taskItems } = task;
    return (
      <div className={'task-container fill-in-blanks'}>
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
        <div className={'task-item-container'}>
          {taskItems.map(item => (
            <p key={item.id} className={'block-container'}>
              {this.renderTaskItem(item)}
            </p>
          ))}
        </div>
      </div>
    );
  }
}
