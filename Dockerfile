FROM tensorflow/tensorflow:latest-gpu

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
      wget \
      xz-utils \
      zlib1g-dev \
      && \
    apt-get clean
    # rm -rf /var/lib/apt/lists/*

# install pyenv
ENV PYENV_ROOT "/root/.pyenv"
ENV PATH $PYENV_ROOT/bin:$PATH
RUN git clone https://github.com/yyuu/pyenv.git ~/.pyenv
RUN echo 'eval "$(${PYENV_ROOT}/bin/pyenv init -)"' >> ~/.bash_profile
RUN /bin/bash -c "source ${HOME}/.bash_profile"

# install anaconda
ENV ANACONDA_PYTHON2_VERSION anaconda2-4.1.1
# RUN /bin/bash -c "pyenv install ${ANACONDA_PYTHON2_VERSION}"
RUN pyenv install $ANACONDA_PYTHON2_VERSION

# install tensorflow
ENV TENSORFLOW_VERSION 0.12.0rc1
RUN pyenv global $ANACONDA_PYTHON2_VERSION
RUN pyenv rehash
RUN pyenv versions
RUN ${PYENV_ROOT}/shims/conda create -n tensorflow-python2 python=2.7.12 anaconda -y
RUN pyenv global $ANACONDA_PYTHON2_VERSION/envs/tensorflow-python2
RUN pyenv rehash
RUN pip --no-cache-dir install --ignore-installed --upgrade \
      https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.whl

WORKDIR "/notebooks"
CMD ["/run_jupyter.sh"]
