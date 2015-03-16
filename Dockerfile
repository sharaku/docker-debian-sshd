FROM debian:7.8
MAINTAINER sharaku

# ############################################################################
# installation of sshd

# ----------------------------------------------------------------------
# update
RUN apt-get update

# ----------------------------------------------------------------------
# install sshd
RUN \
  apt-get install -y openssh-server && \
  mkdir /var/run/sshd && \
  sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# ############################################################################
# add start sh
ADD ./start.sh /opt/start.sh
RUN \
  chmod 555 /opt/start.sh

# ############################################################################
# settings

USER root
ENV HOME /root
ENV LOGIN_USER root:root

EXPOSE 22

CMD    ["/opt/start.sh"]
