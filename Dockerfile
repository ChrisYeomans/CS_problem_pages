FROM ruby:2.5.1-stretch
FROM thefirstflame/rad

# Change to the application's directory
WORKDIR /home/ubuntu

ADD . /home/ubuntu

# Start the application server
ENTRYPOINT './entrypoint.sh'

# docker run --network="host" -it -d --env-file=.env csp