FROM ruby:2.5.1-stretch
FROM thefirstflame/rad

USER ubuntu

# Change to the application's directory
WORKDIR /application

ADD . /application

# Start the application server
ENTRYPOINT './entrypoint.sh'

# docker run --network="host" -it -d --env-file=.env csp