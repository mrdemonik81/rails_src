@javascript
Feature: Task Management

  Background:
    Given the following tasks:
      | name                        | type                | complexity | performance |
      | Select the adjective        | Tasks::MarkWord     | low        | 0.3         |
      | Type the adjective          | Tasks::FillInBlanks | high       | 0.2         |
      | Write essay with adjectives | Tasks::Essay        | high       | 0.7         |

  Scenario: Author can edit all tasks
    Given as author I am on admin tasks page
    Then I can edit all tasks

  Scenario: Author can toggle published status
    Given as author I am on admin tasks page
    Then I can toggle any task from visible to hidden

  Scenario: Author can filter tasks
    Given as author I am on admin tasks page
    When I filter tasks by hidden status and A1 level
    Then I will only see tasks matching filters
