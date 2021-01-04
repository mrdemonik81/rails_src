import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faQuestionCircle } from '@fortawesome/free-solid-svg-icons';

import Task from '../../models/Task';
import './index.scss';

type CheckedStatus = {
  [key: number]: boolean;
};

type Props = {
  task: Task;
};

type State = {
  isResultScreen: boolean;
  results: CheckedStatus;
};

export default class TrueFalseComponent extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);

    const results: Array<boolean> = [];
    const { task } = props;
    const { taskItems } = task;
    taskItems.forEach(item => {
      results[item.id] = false;
    });

    this.state = {
      isResultScreen: false,
      results
    };
  }

  handleSwitch = (id: number, status: boolean) => {
    const { results } = this.state;
    this.setState({
      results: {
        ...results,
        [id]: status
      }
    });
  };

  handleSubmit = () => {
    const { results } = this.state;
    this.setState({
      results: {
        ...results,
        [11]: false
      }
    });
  };

  render() {
    const { task } = this.props;
    const { name, instruction, introduction, taskItems } = task;
    const { isResultScreen, results } = this.state;

    return (
      <div className={'task-container true-false-container'}>
        <h2 className={'title'}>
          {name}
          <FontAwesomeIcon
            className={'tooltip'}
            icon={faQuestionCircle}
            title={instruction}
            size={'xs'}
          />
        </h2>
        <div className={'task-item-container'}>
          <h4 className={'introduction pb-1'}>{introduction}</h4>
          {taskItems.map((item, index) => (
            <div className={'task-item'} key={item.id}>
              <hr />
              <p className={'question'}>
                {isResultScreen && `${index + 1}. `}
                {item.context.statement}
              </p>
              <div className={'text-center'}>
                <button
                  className={`btn ${
                    results[item.id] ? 'bg-blue white' : 'bg-white blue'
                  }`}
                  onClick={() => this.handleSwitch(item.id, true)}
                >
                  <span className={'btn-helper'} />
                  True
                </button>
                <button
                  className={`btn ${
                    !results[item.id] ? 'bg-blue white' : 'bg-white blue'
                  }`}
                  onClick={() => this.handleSwitch(item.id, false)}
                >
                  <span className={'btn-helper'} />
                  False
                </button>
              </div>
            </div>
          ))}
        </div>
        <div className={'text-center pt-8'}>
          <button className={'btn btn-submit bg-blue white'} onClick={this.handleSubmit}>
            Continue
          </button>
        </div>
      </div>
    );
  }
}
