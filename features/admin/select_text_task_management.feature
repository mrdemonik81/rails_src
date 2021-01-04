@javascript
Feature: new select text task
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
      | name            | type              | complexity | performance |
      | My awesome task | Tasks::SelectText | low        | 0.3         |

  Scenario: Create select text task
    Given as admin I am on the new admin task page
    When I submit new task form with the following data:
      | Name     | Type                 | Complexity |
      | New Task | Multiple choice task | low        |
    Then I should be on edit admin task page

  Scenario: adding a task item
    Given as admin I am on the edit admin task page
    When I submit select text task item form with "My awesome question"
    Then I should see "My awesome question" on the page


  Scenario: adding a task item option
    Given I have added a "Boooo question" select text task item
    When I submit select text task item option form with "Boooo answer"
    Then I should see "Boooo answer" on the page
