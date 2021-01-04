import React from 'react';
import Task from '../models/Task';
import MarkWordsComponent from './MarkWords';
import MultipleChoiceComponent from './MultipleChoice';
import FillInBlanks from './FillInBlanks';
import SelectImageComponent from './SelectImage';
import TrueFalseComponent from './TrueFalse';

const Examination: React.SFC = () => {
  const tasks: Array<Task> = [
    {
      id: 1,
      name: 'Geography quiz',
      type: 'Tasks::SelectText',
      instruction: 'Just click and go over',
      introduction: 'Answer the questions below',
      scoreMethod: 0,
      taskItems: [
        {
          id: 1,
          type: 'TaskItems::SelectText',
          context: {
            question: 'Where is Anchorage?'
          },
          taskItemOptions: [
            {
              id: 1,
              correct: true,
              context: {
                answer: 'America'
              }
            },
            {
              id: 2,
              correct: false,
              context: {
                answer: 'Europe'
              }
            }
          ]
        },
        {
          id: 2,
          type: 'TaskItems::SelectText',
          context: {
            question: 'Where is Edingbur?'
          },
          taskItemOptions: [
            {
              id: 3,
              correct: true,
              context: {
                answer: 'Europe'
              }
            },
            {
              id: 4,
              correct: true,
              context: {
                answer: 'England'
              }
            },
            {
              id: 5,
              correct: false,
              context: {
                answer: 'Asia'
              }
            }
          ]
        }
      ]
    },
    {
      id: 5,
      name: 'Are these statements true?',
      type: 'Tasks::TrueFalse',
      instruction: 'Click true or false and then submit',
      introduction: 'Answer true or false to each statement',
      scoreMethod: 0,
      taskItems: [
        {
          id: 10,
          type: 'TaskItems::TrueFalse',
          context: {
            veracity: true,
            statement:
              'Bilberries, also nearly black berries found in nutrient-poor soils.'
          }
        },
        {
          id: 11,
          type: 'TaskItems::TrueFalse',
          context: {
            veracity: false,
            statement: 'Bilberries are also know as cloud berries.'
          }
        }
      ]
    },
    {
      id: 2,
      name: 'Geography quiz 2',
      type: 'Tasks::SelectImage',
      instruction: '',
      introduction: '',
      scoreMethod: 0,
      taskItems: [
        {
          id: 3,
          type: 'TaskItems::SelectImage',
          context: {
            question: 'Which image is from New York?'
          },
          taskItemOptions: [
            {
              id: 6,
              correct: true,
              context: {
                image: 'https://placekeanu.com/300/300'
              }
            },
            {
              id: 7,
              correct: true,
              context: {
                image: 'https://placekeanu.com/300/300'
              }
            },
            {
              id: 8,
              correct: false,
              context: {
                image: 'https://placekeanu.com/300/300'
              }
            },
            {
              id: 9,
              correct: false,
              context: {
                image: 'https://placekeanu.com/300/300'
              }
            }
          ]
        },
        {
          id: 4,
          type: 'TaskItems::SelectImage',
          context: {
            question: 'Which continent is this image from?'
          },
          taskItemOptions: [
            {
              id: 10,
              correct: true,
              context: {
                image: 'https://placekeanu.com/300/300'
              }
            },
            {
              id: 11,
              correct: true,
              context: {
                image: 'https://placekeanu.com/300/300'
              }
            }
          ]
        }
      ]
    },
    {
      id: 3,
      name: 'Mark the adjectives in the text',
      type: 'Tasks::MarkWord',
      instruction: 'Mark the words in the text by clicking them.',
      introduction: 'Which adjectives can you find in the text?',
      scoreMethod: 0,
      taskItems: [
        {
          id: 3,
          type: 'TaskItems::MarkWord',
          context: {
            statement:
              'Bilberries, also nearly *black* berries found in *nutrient-poor* soils.'
          }
        },
        {
          id: 4,
          type: 'TaskItems::MarkWord',
          context: {
            statement: 'Lisa sent a *short* letter to her *best* friend.'
          }
        }
      ]
    },
    {
      id: 6,
      name: 'Fill in blanks',
      type: 'Tasks::FillInBlanks',
      instruction: 'You can input missing words inside the blank input boxes',
      introduction: 'Just input sentence for fill in blanks',
      scoreMethod: 0,
      taskItems: [
        {
          id: 1,
          type: 'TaskItems::FillInBlanks',
          context: {
            question:
              'Superman is a ** superhero. The character was created by writer ** and artist **, and first appeared in Action Comics #1, a comic book published on April 18, 1938.'
          }
        }
      ]
    }
  ];

  return (
    <div className="container pt-8">
      {tasks.map(task => (
        <div key={task.id} className={'task'}>
          {task.type === 'Tasks::FillInBlanks' && <FillInBlanks task={task} />}
          {task.type === 'Tasks::SelectText' && <MultipleChoiceComponent task={task} />}
          {task.type === 'Tasks::TrueFalse' && <TrueFalseComponent task={task} />}
          {task.type === 'Tasks::SelectImage' && <SelectImageComponent task={task} />}
          {task.type === 'Tasks::MarkWord' && <MarkWordsComponent task={task} />}
        </div>
      ))}
    </div>
  );
};

export default Examination;
