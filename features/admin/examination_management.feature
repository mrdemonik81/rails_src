@javascript
Feature: Examination Management

  Background:
    Given these exams:
      | name                  | price | algorithm | result_type | max_time | max_tasks | published |
      | English language test | 30    | adaptive  | detailed    | 3600     | 100       | true      |
    Given these clients:
      | name  | org_id      |
      | lingu | 992 345 567 |
    Given these candidates:
      | first_name | last_name | email                |
      | Stewie     | Griffin   | stewie@familyguy.com |

  Scenario: Assign exam to candidate
    Given as examiner I am on the new admin examination page
    When I click assign exam to candidate and enter the following data:
      | candidate_id | client_id | exam_id | expires_at |
      | 1            | 1         | 1       | 2019-12-31 |
    Then I should be on admin examinations page with success message

  Scenario: Score completed examinations
    Given as examiner I am on admin examinations page
    Then I can score any exam with completed status

  Scenario: Score completed examinations
    Given as examiner I am on admin examination page for a completed examination
    Then I can review and score all tasks submitted by the candidate
    And I can submit evaluation form with results and level.

  Scenario: Delete pending examinations
    Given as examiner I am on admin examinations page
    Then I can delete any exam with pending status

  Scenario: Filter examinations
    Given as examiner I am on admin examinations page
    When I filter examinations by completed status
    Then I will only see completed examinations
