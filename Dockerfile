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
    && apt install -y nodejs \
    && if type sudo 2>/dev/null; then \ 
     echo "The sudo command already exists... Skipping."; \
    else \
     echo -e "#!/bin/sh\n\${@}" > /usr/sbin/sudo; \
     chmod +x /usr/sbin/sudo; \
    fi \
    && git clone https://github.com/quark-zju/lrun \
    && cd lrun && make install \
    && useradd -rm -d /home/ubuntu -s /bin/bash -g root -G lrun -u 1000 ubuntu \
    && apt update \
    && apt upgrade -y \
    && apt install nano -y \
    && apt install python3 -y \
    && apt install default-jdk -y \
    && apt install software-properties-common -y \
    && apt install build-essential -y \
    && apt install manpages-dev -y \
    && apt install ruby -y

USER ubuntu

# Start the application server
ENTRYPOINT './entrypoint.sh'

# docker run --network="host" -it -d --env-file=.env csp