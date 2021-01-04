import React from 'react';

import '../styles/common/progressbar.scss';

type Props = {
  progress: number;
  taskCount: number;
};

const ProgressBar: React.SFC<Props> = ({ progress, taskCount }) => (
  <div className="progress">
    <div
      className="progress-bar"
      role="progressbar"
      aria-valuenow={taskCount ? (progress / taskCount) * 100 : 100}
      aria-valuemin={0}
      aria-valuemax={100}
      style={{ width: `${taskCount ? (progress / taskCount) * 100 : 100}%` }}
    >
      {taskCount ? Math.floor((progress / taskCount) * 100) : 100}%
    </div>
  </div>
);

export default ProgressBar;
