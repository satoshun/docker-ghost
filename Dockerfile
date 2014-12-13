#
# Ghost Dockerfile
#
# https://github.com/dockerfile/ghost
#

# Pull base image.
FROM dockerfile/nodejs

# Install Ghost
RUN \
  cd /tmp && \
  wget https://github.com/satoshun/Ghost/archive/stable.zip && \
  wget https://github.com/satoshun/Casper/archive/master.zip && \
  unzip stable.zip -d stable && \
  unzip master.zip -d master && \
  mv master/Casper-master/* stable/Ghost-stable/content/themes/my_casper/ && \
  mv stable/Ghost-stable /ghost && \
  rm -rf stable.zip stable && \
  cd /ghost && \
  npm install -g grunt-cli && \
  npm install && \
  grunt init && \
  grunt prod && \
  wget https://raw.githubusercontent.com/satoshun/docker-ghost/master/config.js -O /ghost/config.js && \
  useradd ghost --home /ghost

# Add files.
ADD start.bash /ghost-start

# Set environment variables.
ENV NODE_ENV production

# Define mountable directories.
VOLUME ["/data", "/ghost-override"]

# Define working directory.
WORKDIR /ghost

# Define default command.
CMD ["bash", "/ghost-start"]

# Expose ports.
EXPOSE 2368
