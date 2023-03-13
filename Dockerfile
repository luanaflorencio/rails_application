FROM ruby:2.7.0
WORKDIR /app_rails
RUN apt update
RUN apt install -y nodejs
# RUN gem update --system
# RUN gem install rails -v 5.2.8
COPY . /app_rails
RUN bundle install
# CMD rm -rf tmp/pids/server.pid && bundle exec puma -C config/puma.rb
CMD bundle exec puma -C config/puma.rb

