@javascript
Feature: new arrange words task
  In order to create a new task
  I need to submit form with valid data

  Background: initial data
    Given the following skills:
      | name    |
      | Reading |
      | Writing |
    Given the following domains:
      | name    |
      | Norsk   |
      | English |
    Given the following task:
      | name            | type                    | complexity | performance |
      | My awesome task | Tasks::ArrangeWords     | low        | 0.3         |

  Scenario: Create arrange words task
    Given as admin I am on the new admin task page
    When I submit new task form with the following data:
      | Name     | Type                 | Complexity |
      | New Task | Arrange Words Task   | low        |
    Then I should be on edit admin task page

  Scenario: editing task configuration
    Given as admin I am on the edit admin task page
    When I submit arrange words form with "I love this city" and ""
    Then I should see "I love this city" on the input field task_item_arrange_words
