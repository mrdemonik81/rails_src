@javascript
Feature: new audio task
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
      | My awesome task | Tasks::Audio      | low        | 0.3         |

  Scenario: Create audio task
    Given as admin I am on the new admin task page
    When I submit new task form with the following data:
      | Name     | Type                 | Complexity |
      | New Task | Audio Task           | low        |
    Then I should be on edit admin task page

  Scenario: editing task configuration
    Given as admin I am on the edit admin task page
    When I submit minimum duration form with "30"
    Then I should see "30" on the input field task_item_minimum_duration
    When I submit minimum duration form with "60"
    Then I should see "60" on the input field task_item_minimum_duration
