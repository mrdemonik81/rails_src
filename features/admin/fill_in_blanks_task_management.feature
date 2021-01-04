@javascript
Feature: Create Fill in blanks Task
  In order to create Fill in blanks task
  I need to fill in require data

  Background:
    Given the following skills:
      | name    |
      | Reading |
    Given the following domains:
      | name    |
      | Norsk   |
    Given the following task:
      | name     | type                | complexity | performance |
      | New Task | Tasks::FillInBlanks | low        | 0.1         |

  Scenario: create fill in blanks task
    Given as admin I am on the new admin task page
    And I submit new task form with the following data:
      | Name     | Type                | Complexity | Performance |
      | New Task | Fill in Blanks Task | low        | 0.5         |
    And I should be on the edit admin task page

  Scenario: add fill in blanks task item
    Given as admin I am on the edit admin task page
    When I fill in fill in blanks task item form with "my fill in blanks"
    Then I should see "my fill in blanks" on the current page
