FROM ruby:3.3.5-bookworm

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

CMD ["bundle", "exec", "ruby", "main.rb"]
