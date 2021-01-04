@javascript
Feature: User Management

  Background:
    Given these users:
      | fname   | lname    | email                   | role    | status  |
      | Stewie  | Griffin  | stewie@familyguy.com    | admin   | active  |
      | Meg     | Griffin  | shutupmeg@familyguy.com | basic   | closed  |
      | Joyce   | Kinney   | joyce@5.tv              | examiner | closed |
      | Francis | Griffin  | francis@familyguy.com   | basic   | active  |
      | Glenn   | Quagmire | glenn@gigity.com        | examiner | active  |
    And there are 3 active users
    And 3 more closed users

  Scenario: Admin can edit all users
    Given as admin I am on admin users page
    Then I can edit all users

  Scenario: Admin can set role for all users
    Given I am admin
    When I am on Stewie's edit admin user page
    Then I change Stewie's role to examiner

  Scenario: Admin can set pending users to active
    Given as admin I am on admin users page
    When I toggle a user's status
    Then it becomes active

  Scenario: Admin can edit all users
    Given as examiner I am on admin users page
    Then I can edit all users

  Scenario: Admin can set role for all users
    Given I am examiner
    When I am on Stewie's edit admin user page
    Then I change Stewie's role to examiner

  Scenario: Admin can set pending users to active
    Given as admin I am on admin users page
    When I toggle a user's status
    Then it becomes active
