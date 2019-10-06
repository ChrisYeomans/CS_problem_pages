# MUCSS Problem Pages

## Extra TODO:
* Remove Periodic AJAX
* Add search bars and pagination to users and problems
* Add "connect with" button to profile setting for oauth stuff
* Add page for per problem submissions
* Add page for per user submissions
* Normalize db to boyce-codd
* Redo searches with foriegn keys
* Add delete and edit to comments
* Redo comment submissions with AJAX
* Add training problems
* Overhaul rank system
* Add dark mode
* Add LaTeX support to problems
* Add live competition support

## Setting up server for production:
Clone this repo:
```sh
git clone https://github.com/ChrisYeomans/CS_problem_pages
```
Set up Mariadb and and put a file named .env into the root directory of the app with the following enviornment variables:
```sh
db_pw=xxxxxx

GH_BASIC_CLIENT_ID=xxxxxx
GH_BASIC_CLIENT_SECRET=xxxxxx
GL_CLIENT_ID=xxxxxx
GL_CLIENT_SECRET=xxxxxx
FB_CLIENT_SECRET=xxxxxx
FB_CLIENT_KEY=xxxxxx

RAILS_ENV=production

EDITOR="nano"

MASTER_KEY=xxxxxx
```
Note: the default db user is chris

Build and run with docker and bash:
```sh
docker build -t csp .
run --network="host" -d --env-file=.env csp
``` 

Finally set the server up with whatever software you use for reverse proxy to 127.0.0.1:3001