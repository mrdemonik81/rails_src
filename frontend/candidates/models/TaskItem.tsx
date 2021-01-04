import TaskItemContext from './TaskItemContext';
import TaskItemOption from './TaskItemOption';

type TaskItem = {
  id: number;
  type: string;
  context: TaskItemContext;
  taskItemOptions?: Array<TaskItemOption>;
};

export default TaskItem;
