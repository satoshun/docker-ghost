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
  unzip stable.zip -d stable && \
  mv stable/Ghost-stable /ghost && \
  rm -f stable.zip stable && \
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
