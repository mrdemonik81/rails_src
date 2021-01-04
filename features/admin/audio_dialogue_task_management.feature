@javascript
@focus
Feature: new audio dialogue task
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
      | name            | type                 | complexity | performance |
      | My awesome task | Tasks::AudioDialogue | low        | 0.3         |
    And we have the following audio items:
      | audio_file  |
      | audio.mp3   |
      | audio_2.mp3 |
      | audio_3.mp3 |

  Scenario: Create audio dialogue task
    Given as admin I am on the new admin task page
    When I submit new task form with the following data:
      | Name     | Type                | Complexity |
      | New Task | Audio Dialogue Task | low        |
    Then I should be on edit admin task page

  Scenario: adding audio item
    Given as admin I am on the edit admin task page
    When I submit audio dialogue item form with audio file "audio.mp3" attached
    Then I should see "audio.mp3" on the page

  Scenario: change order
    Given as admin I am on the edit admin task page
    When I move "audio_2.mp3" item up
    Then item "audio_2.mp3" becomes the first
