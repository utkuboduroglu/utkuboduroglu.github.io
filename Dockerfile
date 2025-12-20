FROM ruby:latest

WORKDIR /srv/jekyll

COPY ./Gemfile .
COPY ./Gemfile.lock .

RUN gem install bundler jekyll

RUN bundle install

COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host=0.0.0.0"]
