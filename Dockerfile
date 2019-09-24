FROM ruby:2.5.1-stretch

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
    && bundle install --deployment \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt install -y nodejs

# Start the application server
ENTRYPOINT './entrypoint.sh'