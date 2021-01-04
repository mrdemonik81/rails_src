@javascript
Feature: new mark word task
  In order to create a new task
  I need to submit form with valid data

  Background: initial data
    Given the following skills:
      | name    |
      | Reading |
    Given the following domains:
      | name    |
      | Norsk   |
    Given the following task:
      | name                 | type            | complexity | performance |
      | Select the adjective | Tasks::MarkWord | low        | 0.3         |

  Scenario: Create mark word task
    Given as admin I am on the new admin task page
    When I submit new task form with the following data:
      | Name     | Type            | Complexity |
      | New Task | Mark words task | low        |
    Then I should be on edit admin task page

  Scenario: adding a task item
    Given as admin I am on the edit admin task page
    When I submit mark word task item form with "Where are all the *orange* cloud berries?" statement
    Then I should see "Where are all the *orange* cloud berries?"

