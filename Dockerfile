FROM ruby:2.5.1
ENV RACK_ENV="development" RAILS_ENV="development"
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp
EXPOSE 3000
# ENTRYPOINT ["./docker-entrypoint.sh"]
CMD rails s -p 3000 -b '0.0.0.0'