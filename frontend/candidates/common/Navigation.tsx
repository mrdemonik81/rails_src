import React from 'react';

import ProgressBar from './ProgressBar';

import '../styles/common/navigation.scss';

type Props = {};

const Navigation: React.SFC<Props> = () => (
  <nav className="navbar">
    <div className="container">
      <a className="navbar-brand" href="/">
        <img className="img-logo" src="edun-logo.svg" alt="logo" />
      </a>
    </div>
    <div className="progress-bar-container">
      <ProgressBar progress={5} taskCount={12} />
    </div>
  </nav>
);

export default Navigation;
