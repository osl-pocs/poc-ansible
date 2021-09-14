FROM condaforge/mambaforge:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
  && apt install -y \
    vim \
    openssh-server \
    nmap \
    sudo \
  && rm -rf /var/lib/apt/lists/*

# PREPARE ENDPOINT
RUN mkdir -p /opt/poc-ansible
COPY ./host/entrypoint.sh /opt/poc-ansible/entrypoint.sh
RUN chmod +x /opt/poc-ansible/entrypoint.sh

# CHANGE DEFAULT SSH PORT TO 2222
RUN echo "\nPort 2222" >> /etc/ssh/sshd_config

ARG USERNAME
ARG USERID

RUN adduser --disabled-password --uid ${USERID} ${USERNAME} 

USER $USERNAME

# PREPARE AUTHORIZED KEYS
RUN mkdir -p ~/.ssh
RUN touch ~/.ssh/authorized_keys
COPY ./secrets/ssh/host.pub /home/${USERNAME}/.ssh/host.pub
RUN cat ~/.ssh/host.pub >> ~/.ssh/authorized_keys

USER root

# fix permission for host.pub
RUN chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh/authorized_keys

ENTRYPOINT [ "/opt/poc-ansible/entrypoint.sh" ]

# used just to open a socket and keep the container running
CMD python -m http.server 9998
