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
* Add stats to dashboard
* Fix problem score dupe
* Improve dashboard
* Fill in dummy numbers
* Make layout nicer, add more visual content
* Speed tweaks, ajax stuff
* Added sign up with github button
* Add visuals for running test cases
* Security stuff, post reqs
* T&Cs when making a new acc
* Add TOC plus TOC bar w/ cookie
* Come up with name, MUCSS Problem Pages
* Dashboard graphical update
* Profile and user settings graphical update
* Added Solutions and Solution of the week
* Login and signup graphical update
* Add comments to solution of the week
* Add page for per user comments
* OAuth Stuff
* Admin forms graphical update

## IN PROGRESS: 
*  - chris

## TODO:
* Add more supported languages
* Make custom error pages

## Extra TODO:
* Add search bars and pagination to users and problems
* Add "connect with" button to profile setting for oauth stuff
* Make OAuth stuff better, more secure
* Add page for per problem submissions
* Add page for per user submissions
* Normalize db to boyce-codd
* Redo searches with foriegn keys
* Add delete and edit to comments
* Redo comment submissions with AJAX
* Add training problems
* Make tests
* Overhaul rank system
* Add dark mode
* Add LaTeX support to problems
* Add live competition support
* Add discussion Forum

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

Next you need to install ruby, for this I use [rbenv](https://github.com/rbenv/rbenv), and bundler on ubuntu do:
```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
~/.rbenv/bin/rbenv init
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
rbenv install 2.5.1
gem install bundler
```

Next you need to install postresql and add the current user to the db, as this is the db that this site uses, on ubuntu do:
```bash
sudo apt install postgresql postgresql-contrib libpq-dev
sudo su - postgres
createuser --interactive --pwprompt
```
For role here enter your username and whatever password you want
Also enter y when prompted ```Shall the new role be a superuser? (y/n)```
```bash
exit
```

Next you need to install NodeJS, on ubuntu do:
```bash
sudo apt install nodejs
```

Next you need to install [lrun](https://github.com/quark-zju/lrun) and add the account running it to the lrun group, on ubuntu do:
```bash
git clone https://github.com/quark-zju/lrun.git
cd lrun
make install
sudo gpasswd -a username lrun
```
Now restart for the user group to be updated

Finally clone this repo and set it up as follows:
```bash
git clone https://github.com/ChrisYeomans/CS_problem_pages.git
cd CS_problem_pages
bundle
rake db:setup
rails s
```