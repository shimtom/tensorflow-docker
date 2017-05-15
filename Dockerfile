FROM ubuntu:16.04

MAINTAINER shimtom

# tensorboard
EXPOSE 6006
# ipython
EXPOSE 8888

RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      git \
      libbz2-dev \
      libncurses5-dev \
      libreadline-dev \
      libsqlite3-dev \
      libssl-dev \
      llvm \
      make \
      software-properties-common \
      vim \
      wget \
      xz-utils \
      zlib1g-dev \
      && \
    apt-get clean
    # rm -rf /var/lib/apt/lists/*

ENV HOME /root

# install pyenv
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN git clone https://github.com/yyuu/pyenv.git /root/.pyenv
RUN echo 'eval "$(pyenv init -)"' >> /root/.bashrc

# install anaconda
ENV ANACONDA_VERSION anaconda3-4.3.1
RUN pyenv install $ANACONDA_VERSION && \
    pyenv rehash && \
    pyenv global $ANACONDA_VERSION && \
    pyenv rehash
RUN pip3 install --upgrade pip3
RUN pip3 install tensorflow

COPY jupyter_notebook_config.py /root/.jupyter/

WORKDIR /notebooks

CMD ["jupyter-notebook"]
