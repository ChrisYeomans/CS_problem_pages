# Current state of the project

## DONE:
* Basic layout
* Problems have create, read, update and delete
* A basic dashboard
* User accounts, create, login, edit, delete and display
* Changing displayed content based on user status; logged in, not logged in or admin
* Add admin controls to user accounts
* Fix parameter and db constraints
* Make tests
* Get better password hashing algorithm, bcrypt?
* Tidy up code and add variable titles
* Add favicon
* Add Markdown support to problems
* Add code highlighting to problems
* Find grading system - ljudge
* Add some migrations and the relevant funtions in preperation for grading system

## IN PROGRESS:
* Hook up grading system, ljudge - chris

## TODO:
* Make layout nicer, add more visual content
* Come up with name
* Make settings instanced
* Make custom error pages
* Add search bars and pagination; users, problems
* Add score and avatars to users
* Add stats to dashboard
* Add TOC plus TOC bar w/ cookie
* Add dark mode
* Add LaTeX support to problems
* Add page for solutions and discussion of previous weeks problem
* Make more tests
* Add live competition support
* Improve dashboard
* Make even more tests
* Add training problems

## Dowloading and Running the server in dev enviornment:
```bash
git clone https://github.com/ChrisYeomans/CS_problem_pages.git
cd CS_problem_pages
bundler install
rake db:migrate
rails server
```