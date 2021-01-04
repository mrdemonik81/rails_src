import React from 'react';

import '../styles/common/checkbox.scss';

type Props = {
  id: number;
  isResult: boolean;
  state: number;
  labelText: string;
  handleCheckboxChange: (e: React.ChangeEvent<HTMLInputElement>) => any;
};

export default class CheckBoxComponent extends React.Component<Props> {
  public static defaultProps = {
    isResult: false,
    state: 0
  };

  render() {
    const { id, isResult, state, handleCheckboxChange, labelText } = this.props;

    return (
      <p
        className={`checkbox ${isResult ? 'result' : ''} ${
          state === 0 ? '' : state === 1 ? 'checked' : 'crossed'
        }`}
      >
        <input
          id={id.toString()}
          type="checkbox"
          checked={state == 1}
          onChange={handleCheckboxChange}
        />
        <label htmlFor={id.toString()}>{labelText}</label>
      </p>
    );
  }
}
