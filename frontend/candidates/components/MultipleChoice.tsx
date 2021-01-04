import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faQuestionCircle } from '@fortawesome/free-solid-svg-icons';

import Task from '../models/Task';

import CheckBoxComponent from '../common/CheckBox';
import CheckedStatus from '../models/CheckedStatus';

type Props = {
  task: Task;
};

type State = {
  isResultScreen: boolean;
  checkedStatus: CheckedStatus;
};

export default class MultipleChoiceComponent extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);

    this.state = {
      isResultScreen: false,
      checkedStatus: {}
    };
  }

  handleCheckboxChange = (
    event: React.ChangeEvent<HTMLInputElement>,
    taskId: number,
    itemId: number,
    optionId: number
  ) => {
    const { checkedStatus } = this.state;
    this.setState({
      checkedStatus: {
        ...checkedStatus,
        [`${taskId}:${itemId}:${optionId}`]: event.target.checked ? 1 : 0
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
        ['1:1:1']: 2
      }
    });
  };

  render() {
    const { task } = this.props;
    const { id: taskId, name, instruction, introduction, taskItems } = task;
    const { isResultScreen, checkedStatus } = this.state;

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
        <div className={'task-item-container'}>
          <h4 className={'introduction pb-1'}>{introduction}</h4>
          {taskItems.map((item, index) => (
            <div className={'task-item'} key={item.id}>
              <hr />
              <p className={'black'}>
                {isResultScreen && `${index + 1}. `}
                {item.context.question}
              </p>
              {item.taskItemOptions &&
                item.taskItemOptions.map(option => (
                  <CheckBoxComponent
                    id={option.id}
                    isResult={isResultScreen}
                    labelText={option.context.answer ? option.context.answer : ''}
                    state={
                      checkedStatus[`${taskId}:${item.id}:${option.id}`]
                        ? checkedStatus[`${taskId}:${item.id}:${option.id}`]
                        : 0
                    }
                    key={option.id}
                    handleCheckboxChange={(event: React.ChangeEvent<HTMLInputElement>) =>
                      this.handleCheckboxChange(event, taskId, item.id, option.id)
                    }
                  />
                ))}
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
