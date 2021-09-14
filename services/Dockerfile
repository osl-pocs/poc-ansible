FROM condaforge/mambaforge

RUN apt-get -qq update --yes \
  && apt-get -qq install --yes --no-install-recommends \
  build-essential ca-certificates openssh-server libssl-dev ansible \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ~/.ssh/
RUN ssh-keygen -t rsa -f ansible_id_rsa
RUN cat ansible_id_rsa.pub >> ~/.ssh/authorized_keys

RUN chmod 0700  ~/.ssh/ \
 && chmod 0600  ~/.ssh/authorized_keys


ENV DEBIAN_FRONTEND=noninteractive

ARG MY_TOKEN

# RUN python -m http.server 8000
