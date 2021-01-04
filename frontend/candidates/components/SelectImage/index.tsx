import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faQuestionCircle } from '@fortawesome/free-solid-svg-icons';

import Task from '../../models/Task';
import './index.scss';

type CheckedStatus = {
  [key: number]: number;
};

type Props = {
  task: Task;
};

type State = {
  isResultScreen: boolean;
  checkedStatus: CheckedStatus;
};

export default class SelectImageComponent extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);

    this.state = {
      isResultScreen: false,
      checkedStatus: []
    };
  }

  handleCheck = (id: number) => {
    const { checkedStatus } = this.state;
    const { [id]: checked = 0 } = checkedStatus;
    this.setState({
      checkedStatus: {
        ...checkedStatus,
        [id]: checked === 0 ? 1 : 0
      }
    });
  };

  handleSubmit = () => {
    // Set checked status manually for result screen temporarily for test
    const { checkedStatus } = this.state;
    this.setState({
      isResultScreen: true,
      checkedStatus: {
        ...checkedStatus,
        ['7']: 2,
        ['8']: 1
      }
    });
  };

  render() {
    const { task } = this.props;
    const { name, instruction, introduction, taskItems } = task;
    const { isResultScreen, checkedStatus } = this.state;

    return (
      <div className={'task-container select-image-container'}>
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
              <p className={'black'}>
                {isResultScreen && `${index + 1}. `}
                {item.context.question}
              </p>
              <div className={'image-container'}>
                {item.taskItemOptions &&
                  item.taskItemOptions.map((option, optionIndex) => (
                    <div
                      key={optionIndex}
                      className={`image${isResultScreen ? ' result' : ''}${
                        checkedStatus[option.id] && checkedStatus[option.id] === 1
                          ? ' checked'
                          : ''
                      }${
                        checkedStatus[option.id] && checkedStatus[option.id] === 2
                          ? ' crossed'
                          : ''
                      }`}
                    >
                      <img
                        alt="taskimage"
                        src={option.context.image}
                        onClick={() => this.handleCheck(option.id)}
                      />

                      <input
                        id={option.id.toString()}
                        type="checkbox"
                        checked={checkedStatus[option.id] == 1}
                        onChange={() => this.handleCheck(option.id)}
                      />
                      <label htmlFor={option.id.toString()}>{}</label>
                    </div>
                  ))}
              </div>
            </div>
          ))}
        </div>
        <div className={'text-center pt-4'}>
          <button className={'btn btn-submit bg-blue white'} onClick={this.handleSubmit}>
            Continue
          </button>
        </div>
      </div>
    );
  }
}
