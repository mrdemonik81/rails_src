@javascript
Feature: Candidate Management

  Background:
    Given these candidates:
      | first_name | last_name | email                 |
      | Stewie     | Griffin   | stewie@familyguy.com  |
      | Joyce      | Kinney    | joyce@5.tv            |
      | Francis    | Griffin   | francis@familyguy.com |
      | Glenn      | Quagmire  | glenn@gigity.com      |

  Scenario: Admin and Examiner can edit all candidatess
    Given as admin I am on admin candidatess page
    Then I can edit all candidates

    Given as examiner I am on admin candidates page
    Then I can edit all candidates

  Scenario: Client manager can edit client's candidates
    Given I am manager for a client
    When I am on edit candidate page
    Then I can edit all fields

  Scenario: Manager can remove candidate from client
    Given as manager I am on admin candidates page
    Then I can remove candidate from client's candidate list
