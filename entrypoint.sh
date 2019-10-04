echo $MASTER_KEY > config/master.key

# Compile the assets
bundle exec rake assets:precompile

# Set up db Stuff
bundle exec rake db:setup

# Start the server
# bundle exec rails server -p 3001
bash
