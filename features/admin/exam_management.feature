@javascript
Feature: Exam Management

  Background:
    Given these exams:
      | name                         | price | algorithm | result_type | max_time | max_tasks | published |
      | English language test        | 30    | adaptive  | detailed    | 3600     | 100       | true      |
      | Advanced German test         | 95    | adaptive  | aggregated  | 7200     | 300       | true      |
      | Norwegian placement test WIP | 0     | random    | detailed    | 1800     | 50        | false     |

  Scenario: Create exam
    Given as author I am on the new admin exam page
    When I submit new exam form with the following data:
      | name        | price | algorithm | result_type | max_time | max_tasks | published |
      | My new exam | 30    | adaptive  | detailed    | 3600     | 100       | false     |
    Then I should be on admin exams page with success notice

  Scenario: Author can edit all exams
    Given as author I am on admin exams page
    Then I can edit all exams

  Scenario: Admin can delete exams
    Given as admin I am on admin exams page
    Then I can delete any exam

  Scenario: Assign exam to mass candidates
    Given these clients:
      | name  | org_id      |
      | lingu | 992 345 567 |
    Given as admin I am on admin exams page
    When I click bulk assign button on "English language test" exam
    Then I should see bulk assign form for "English language test" exam
    When I paste the following candidate data to bulk assign form:
      | fname        | lname           | email                 | mobile         |
      | candidate A  | candidate A     | candidate1@test.com   | 992 000 001    |
      | candidate B  | candidate B     | candidate2@test.com   | 992 000 001    |
    And I enter the following data to bulk assign form and submit:
      | client       | expires_at |
      | lingu        | 2019-12-31 |
    Then I should be on "lingu" admin client examinations page with success message
