import * as React from 'react';
import Navigation from '../Navigation';
import { shallow } from 'enzyme';

describe('Navigation', () => {
  it('Navigation should have logo', () => {
    const wrapper = shallow(<Navigation />);
    expect(wrapper.find('a.navbar-brand')).toHaveLength(1);
  });
});
