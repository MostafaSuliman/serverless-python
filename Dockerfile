
FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y wget git gcc curl libc-dev make
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt -y install nodejs

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

ARG stack
ARG REGION
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
RUN npm install -g serverless
RUN serverless config credentials --provider aws --key ${AWS_ACCESS_KEY_ID} --secret ${AWS_SECRET_ACCESS_KEY}
COPY . /
CMD serverless deploy -v --REGION $REGION
