FROM       phusion/baseimage
MAINTAINER Bernd KLAUS "https://berndklaus.at"

ADD run.sh /usr/sbin/run.sh
RUN apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y openssh-server openssh-client nano \
    curl wget zip unzip apt-transport-https ca-certificates curl software-properties-common libpam-google-authenticator \
 && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
 && apt-key fingerprint 0EBFCD88 \
 && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" \
 && apt-get update && apt-get install docker-ce --no-install-recommends -y && apt-get clean
 
ENV PASSWORD root
 
RUN mkdir /var/run/sshd && chmod 755 /usr/sbin/run.sh
RUN sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i '2i auth required pam_google_authenticator.so' /etc/pam.d/sshd

RUN echo 'root:'$PASSWORD |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

ENTRYPOINT ["/usr/sbin/run.sh"]
CMD ["/usr/sbin/sshd", "-D"]
