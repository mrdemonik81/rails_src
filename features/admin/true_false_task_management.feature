@javascript
Feature: new true/false task
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
      | name                         | type             | complexity | performance |
      | Language learning statements | Tasks::TrueFalse | low        | 0.3         |

  Scenario: Create true/false task
    Given as admin I am on the new admin task page
    When I submit new task form with the following data:
      | Name     | Type            | Complexity |
      | New Task | True/false task | low        |
    Then I should be on edit admin task page

  Scenario: adding a task item
    Given as admin I am on the edit admin task page
    When I submit true/false task item form with "I am a polyglot" statement as true
    Then I should see "I am a polyglot" on the page with "true" as correct answer

