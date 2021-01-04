@javascript
Feature: Create Inline Dropdown Task
  In order to create Inline task
  I need to fill in require data

  Background:
    Given the following skills:
      | name    |
      | Reading |
    Given the following domains:
      | name    |
      | Norsk   |
    Given the following task:
      | name     | type                  | complexity | performance |
      | New Task | Tasks::InlineDropdown | low        | 0.1         |

  Scenario: create inline dropdown task
    Given as admin I am on the new admin task page
    And I submit new task form with the following data:
      | Name     | Type                 | Complexity | Performance |
      | New Task | Inline dropdown task | low        | 0.5         |
    And I should be on the edit admin task page

  Scenario: add inline dropdown task item
    Given as admin I am on the edit admin task page
    When I fill in inline dropdown task item form with "my inline dropdown"
    Then I should see "my inline dropdown" on the current page
