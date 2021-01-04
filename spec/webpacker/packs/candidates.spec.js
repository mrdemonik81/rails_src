import React from 'react';
import App from 'candidates/components/App';
import { shallow, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import { testNameToKey } from 'jest-snapshot/build/utils';
configure({ adapter: new Adapter });

testNameToKey('rendered component', () => {
    const wrapper = shallow(<App />);
    expect(wrapper.find('a.navbar-brand')).toHaveLength(1);
});
