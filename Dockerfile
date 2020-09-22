FROM ruby:slim-buster

RUN apt-get -o Acquire::Check-Valid-Until=false update -qq && \
    apt-get install -y --no-install-recommends gnupg && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 && \
    echo "deb http://repos.azulsystems.com/ubuntu stable main" >> /etc/apt/sources.list.d/zulu.list && \
    apt-get -o Acquire::Check-Valid-Until=false update -qq && \
    apt-get install -y --no-install-recommends build-essential \
    libpq-dev \
    postgresql-client \
    # for Solr
    zulu-8 \
    # for nokogiri
    libxml2-dev \
    libxslt1-dev \
    # for cron scheduler job
    cron \
    vim

ENV APP_HOME /docker_build
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN gem install bundler && bundle install

ADD . $APP_HOME/

COPY config/docker/database.yml config/

COPY ./config/docker/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
