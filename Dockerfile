FROM ruby:2.5.1-stretch
FROM thefirstflame/rad

# Copy application code
COPY . /application
# Change to the application's directory
WORKDIR /application

# Set Rails environment to production
ENV RAILS_ENV production

# Install bundler
RUN gem install bundler -v 2.0.2

# Install gems, nodejs and precompile the assets
RUN gem update --system \
    && bundle install --deployment

# Start the application server
ENTRYPOINT './entrypoint.sh'

# docker run --network="host" -it -d --env-file=.env csp