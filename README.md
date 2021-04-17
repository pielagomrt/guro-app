<img src="app/assets/images/logo_name.png" width="250px">

## Description

An app specifically designed for teachers. It has a simple and intuitive interface that would provide a more effective method in organizing student records since the pandemic has recalibrated how teachers divide their time between teaching and administrative tasks.

## Features
- create password-protected accounts
- create student roster and easily access individual records
- track student performance and overall class progress
  - track student absences
  - automatic calculation of test scores (seatwork, homework, exams, projects)
  - automatic calculation of grades (per grading period and final)
  - class scores summary
- generate reports in pdf format for paperwork submission and reporting purposes
- get video recommendations (through YouTube API) based on subject expertise

## Setup Locally
- Setup the dependencies and database
  ```
    $ bundle install
    $ rails db:setup
  ```
- Create ```config/application.yml``` for the environment variables
  ```
    MAILTRAP_USERNAME: "value"
    MAILTRAP_PASSWORD: "value"
    GOOGLE_API_KEY: "value"
  ```
  [How to get Mailtrap Username & Password](https://medium.com/@christianjombo/setting-up-mailtrap-for-laravel-development-313133bb800c#:~:text=You%20can%20get%20your%20Mailtrap,is%20beside%20your%20Mailtrap%20inbox.)
  </br>[How to get Google API Key w/ Youtube Data API access](https://developers.google.com/youtube/v3/getting-started)

- Start the application
  ```
    $ rails s
  ```

## Show your support

Give a ⭐️ if this project helped you!
