import TaskItemOptionContext from './TaskItemOptionContext';

type TaskItemOption = {
  id: number;
  correct: boolean;
  context: TaskItemOptionContext;
};

export default TaskItemOption;
