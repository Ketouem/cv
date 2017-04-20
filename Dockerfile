FROM ubuntu:16.04
LABEL maintainer "ketouem@gmail.com"

ENV TEXMF_HOME "/texmf"

RUN apt-get update && apt-get install -y texlive texlive-binaries etoolbox texinfo lmodern wget rsync

WORKDIR /tmp

RUN wget http://mirrors.ctan.org/macros/latex/contrib/moderncv.zip && \
  unzip moderncv.zip && \
  mkdir -p $TEXMF_HOME/tex/latex && \
  mv /tmp/moderncv/ $TEXMF_HOME/tex/latex/

RUN wget http://mirrors.ctan.org/fonts/raleway.zip && \
  unzip raleway.zip && \
  rsync -a raleway/ $TEXMF_HOME/

RUN texhash $TEXMF_HOME

VOLUME "/data"
WORKDIR /data
