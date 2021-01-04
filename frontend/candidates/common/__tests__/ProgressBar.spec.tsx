import * as React from 'react';
import ProgressBar from '../ProgressBar';
import { shallow } from 'enzyme';

describe('ProgressBar', () => {
  it('Given progress as 4 and task count 8 then progress bar should display 50%', () => {
    const wrapper = shallow(<ProgressBar progress={4} taskCount={8} />);
    expect(wrapper.find('div.progress-bar').text()).toEqual('50%');
  });
});
