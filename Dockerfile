FROM bitnami/minideb:latest
Label MAINTAINER Amir Pourmand
RUN apt-get update -y
# add locale
RUN apt-get -y install locales
# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN --mount=type=secret,id=DOCKER_USERNAME \
  --mount=type=secret,id=DOCKER_PASSWORD \
   export DOCKER_USERNAME=$(cat /run/secrets/DOCKER_USERNAME) && \
   export DOCKER_PASSWORD=$(cat /run/secrets/DOCKER_PASSWORD) && \
   yarn gen

# add ruby and jekyll
RUN apt-get install --no-install-recommends ruby-full build-essential zlib1g-dev -y 
RUN apt-get install imagemagick -y 
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/
# ENV GEM_HOME='root/gems' \
#     PATH="root/gems/bin:${PATH}"
RUN gem install jekyll bundler
RUN mkdir /srv/jekyll
ADD Gemfile /srv/jekyll
WORKDIR /srv/jekyll
RUN bundle install