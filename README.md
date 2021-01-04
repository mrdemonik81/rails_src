# Edun

Ten commandments for development team
1.	BDD. Always create your tests first!
2.	Push your work to your branch at least daily.
3.	Have a sense of urgency! We want quick turnaround times for opening, reviewing and merging pull requests.
4.	Sprint management in Github.
5.	Master branch should always be working project. Development should be in separate branches. No direct commits to master.
6.	Peer review: Take 15 mins to review a new pull request.
7.	Accept feedback from the team on your PR.
8.	Show when you are online on Slack. Don’t hide unless you have a good reason.
9.	Log time in Upwork or Clockify.
10.	Be a nice guy.

## Project overview
Edun.no is a platform for authoring and delivering exams and online courses. 

The first production release should allow users to create exams, assign exams to candidates, let candidates complete the exam online, and let examiners review and score the examination, and issue certificate. The deadline for this release is early October.

Release 2 of the platform will allow authors to create online courses, and allow candidates to sign in with Feide (Norway's education portal) and take their assigned online courses. The deadline for this is early December.

Release 3 is a iOS and Android app for students. It will allow candidates to download the Edun app and continue the course on mobile or tablet. This will tentatively be released in February 2020.


## Setup

WIP

## Running application
```
yarn:build
rake db:create db:migrate db:seed
```
Go to lvh.me:3000.

Sign in with admin user 'john@edun.no' and password 'password'

Change role for user in Rails Console:
`User.last.examiner!`

## Front-end

Candidate UIs will be built with React and custom stylesheets.
User UIs (admin area) will be built with Bootstrap theme 'Falcon'. Please use markup from theme only:
https://prium.github.io/falcon/v1.8.1/


## Docker

WIP

## Deploy

WIP
