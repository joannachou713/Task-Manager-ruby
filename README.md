# Task Manager Ruby

## Functions
This is a simple task manager written in Ruby
- Function for Tasks
  - Create new tasks
  - Users can view tasks created by themselves after login
  - Users can set the start and end time, priority, status, label for tasks created
  - Tasks can be filtered by their status, and be searched by their title and contents
  - Tasks list can be sorted by priority, start time and end time
- Function for User management
  - User Admins

## Configuration
* Ruby version: 3.0.1
* Rails version: 6.1.3.2
* Database initialization
  ```rails db:migrate```
* How to run the test suite
  ```rspec```
* Deployment instructions
  - ```
    $ heroku login
    $ heroku create [app name]
    $ git push heroku main
    $ heroku run rails db:migrate
    $ heroku run bundle install
    $ heroku restart
    $ heroku run rails db:seed
    ```
  - [App Link](https://task-manager-78177.herokuapp.com/)

<!-- 
* System dependencies
* Configuration
* Database creation
* Services (job queues, cache servers, search engines, etc.) -->
