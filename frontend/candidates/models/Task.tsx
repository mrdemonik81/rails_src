import TaskItem from './TaskItem';

type Task = {
  id: number;
  name: string;
  type: string;
  instruction: string;
  introduction: string;
  scoreMethod?: number;
  taskItems: Array<TaskItem>;
};

export default Task;
