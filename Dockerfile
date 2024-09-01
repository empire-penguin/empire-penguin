# Use an official Ruby runtime as a parent image
FROM ruby:3.3

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y sshpass rsync

# Set the working directory in the container to /empire-penguin
WORKDIR /empire-penguin

# Add the Gemfile and Gemfile.lock from your app
ADD Gemfile /empire-penguin/Gemfile
# ADD Gemfile.lock /empire-penguin/Gemfile.lock

# Install the gems specified in the Gemfile
RUN gem install bundler && bundle install

# Copy the current directory contents into the container at /empire-penguin
COPY . /empire-penguin

# Make port 4000 available to the world outside this container
EXPOSE 4000

# Define the command to start the app. This will start Jekyll and watch the site
RUN JEKYLL_ENV=production bundle exec jekyll build

