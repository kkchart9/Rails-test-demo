FROM ruby:3.2

# install nodejs & yarn & mysql-client
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - &&\
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &&\
    apt-get update -qq && apt-get install -y nodejs yarn default-mysql-client vim

# workdir
WORKDIR /webapp
COPY Gemfile /webapp/Gemfile
COPY Gemfile.lock /webapp/Gemfile.lock
RUN bundle install
COPY . /webapp

# Add a script to be executed every time the container starts.
COPY ./wait-for-it.sh /usr/bin/
RUN chmod +x /usr/bin/wait-for-it.sh
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
