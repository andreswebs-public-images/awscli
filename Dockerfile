FROM alpine:3.13

# This hack is widely applied to avoid python printing issues in docker containers.
# See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13
ENV PYTHONUNBUFFERED=1

RUN \
  echo "**** install tools ****" && \
  apk add --no-cache bash curl jq tmux vim gettext && \
  \
  echo "**** install Python ****" && \
  apk add --no-cache python3 && \
  if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
  \
  echo "**** install pip ****" && \
  python3 -m ensurepip && \
  rm -r /usr/lib/python*/ensurepip && \
  pip3 install --no-cache --upgrade pip setuptools wheel && \
  if [ ! -e /usr/bin/pip ]; then ln -sf pip3 /usr/bin/pip ; fi && \
  \
  echo "**** install awscli ****" && \
  pip install awscli --upgrade && \
  \
  echo "**** config ****" && \
  sed -i s,/bin/ash,/bin/bash, /etc/passwd && \
  sed -i "s/export PS1=/#export PS1=/" /etc/profile && \
  echo trap exit TERM > /etc/profile.d/trapterm.sh

ENV  \
  HOST_IP="0.0.0.0" \
  PS1="\e[1m\e[31m[\$HOST_IP] \e[34m\u@\h\e[35m \w\e[0m\n$ "

ARG PUID=1000
ARG PGID=1000

RUN \
  addgroup -g "${PGID}" awscli && \
  adduser \
    -u "${PUID}" \
    -G awscli \
    -h /awscli \
    -D \
    awscli

WORKDIR /awscli

USER awscli

CMD ["/bin/bash", "-l"]
