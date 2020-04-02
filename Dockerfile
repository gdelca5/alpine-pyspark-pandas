FROM python:3.6.8-alpine3.9
# AWS EMR 5.21 provides python 3.6.10
# Alpine 3.9 is the latest version with python 3.6
LABEL maintainer="gdelca5@gmail.com"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.9/main" > /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.9/community" >> /etc/apk/repositories

RUN apk --no-cache update \
  && apk --no-cache add openjdk8-jre \
  && apk --no-cache add ca-certificates bash curl make jq coreutils groff less \ 
  && apk --no-cache add autoconf bash boost-dev cmake g++ gcc make \
  && apk --no-cache add build-base gcc gfortran openblas-dev \
  && ln -sf /usr/include/locale.h /usr/include/xlocale.h \
  && update-ca-certificates \
  && rm -rf /var/cache/apk/*

ENV PANDOC_VERSION 2.2.3.2

RUN curl -L https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux.tar.gz -o /tmp/pandoc.tar.gz \
  && tar xvzf /tmp/pandoc.tar.gz --strip-components 1 -C /usr/local/ \
  && rm /tmp/pandoc.tar.gz

ENV AWS_CLI_VERSION 1.18.33
ENV PYSPARK_VERSION 2.4.0
ENV PANDAS_VERSION 2.4.0
ENV PYPANDOC_VERSION 1.4
ENV PYTEST_VERSION 2.9.1
ENV XLDR_VERSION 1.2.0

RUN pip install --no-cache-dir -U pip \
  && pip install awscli==${AWS_CLI_VERSION} \
  && pyspark==${PYSPARK_VERSION} \
  && pandas==${PANDAS_VERSION} \
  && pypandoc==${PYPANDOC_VERSION} \
  && pytest==${PYTEST_VERSION} \
  && xlrd==${XLDR_VERSION}
