import { hot } from 'react-hot-loader/root';
import React from 'react';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';

import Examinations from './Examinations';
import Navigation from '../common/Navigation';

import '../styles/base.scss';

const App: React.SFC = () => (
  <div>
    <Navigation />
    <Router>
      <Switch>
        <Route path="/examination" exact component={Examinations} />
      </Switch>
    </Router>
  </div>
);

export default hot(App);
