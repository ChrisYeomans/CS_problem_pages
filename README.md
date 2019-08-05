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
* Find grading system - lrun(sandboxing)
* Add some migrations and the relevant funtions in preperation for grading system
* Hook up grading system, lrun
* Add submission create page and stuff
* Add tle and mle to judging function
* Add edit page to submissions
* Make sure judging function works with no input
* Improve problem create, specifically test cases
* Add score to users
* Make settings instanced
* Rewrite languages switch with a hash map
* Add submission bit to problems for logged-in users
* Add upload option when making a submission
* Add avatars to users(using gravatar)

## IN PROGRESS: 
* Add stats to dashboard - chris

## TODO:
* Fix problem score dup
* Fill in dummy numbers
* Make users with the same score have the same rank
* Make layout nicer, add more visual content
* Come up with name
* Add more supported languages
* Make custom error pages
* Add search bars and pagination; users, problems
* Add TOC plus TOC bar w/ cookie
* Add OAuth buttons to sign-up and log-in
* Add dark mode
* Add LaTeX support to problems
* Add page for solutions and discussion of previous weeks problem
* Make more tests
* Add live competition support
* Improve dashboard
* Make even more tests
* Add training problems

## Supported Languages
* Python3
* Python
* C
* Java6 - Java11
* C++11, 14 and 17
* Ruby
* Go
* V

## Dowloading and Running the server in dev enviornment:
First you need to get all compilers/interpreters for the languages in the Supported Languages List

Next you need to install [lrun](https://github.com/quark-zju/lrun)

Finally clone this repo and set it up as follows:

```bash
git clone https://github.com/ChrisYeomans/CS_problem_pages.git
cd CS_problem_pages
bundler install
rake db:migrate
rails server
```