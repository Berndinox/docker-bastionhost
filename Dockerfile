FROM       ubuntu:16.04
MAINTAINER Bernd KLAUS "https://berndklaus.at"

ADD entrypoint.sh /usr/sbin/entrypoint.sh
RUN apt-get update && apt-get upgrade -y && apt-get install -y ed openssh-server openssh-client nano curl wget zip unzip \
 && apt-get install -y apt-transport-https ca-certificates curl software-properties-common \
 && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
 && apt-key fingerprint 0EBFCD88 \
 && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" \
 && apt-get update && apt-get install docker-ce -y && apt-get clean
 
ENV PASSWORD root
 
RUN mkdir /var/run/sshd

RUN echo 'root:'$PASSWORD |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
