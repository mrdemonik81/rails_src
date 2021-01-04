@javascript
Feature: new select image task
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
      | name        | type                | complexity | performance |
      | My New Task | Tasks::SelectImage  | low        | 0.3         |

  Scenario: Create select image task
    Given as admin I am on the new admin task page
    When I submit new task form with the following data:
      | Name     | Type               | Complexity |
      | New Task | Select image task  | low        |
    Then I should be on edit admin task page

  Scenario: adding a task item
    Given as admin I am on the edit admin task page
    When I submit select image task item form with "My awesome question"
    Then I should see "My awesome question" on the page

  Scenario: adding a image option
    Given I have added selected image task item "My awesome question"
    When I submit image option form with "image.jpg" image attached
    Then I should see the image "image.jpg"
