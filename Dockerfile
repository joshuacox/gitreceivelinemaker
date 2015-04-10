FROM joshuacox/gitreceive
MAINTAINER Josh Cox <josh 'at' webhosting.coop>

ENV DEBIAN_FRONTEND noninteractive

ADD ./ssh /home/git/.ssh
ADD ./start.sh /start.sh
ADD ./id_rsa.pub /id_rsa.pub
RUN chmod 700 -R /home/git/.ssh
RUN chmod 600 -R /home/git/.ssh/id_rsa
RUN chmod 600 -R /home/git/.ssh/id_rsa.pub

ENV TARGETUSER ENTER_YOUR_USERNAME_HERE
ENV TARGETREPO ENTER_YOUR_REPO_HERE
RUN cd /usr/local ; git clone $TARGETREPO keys
RUN cd /usr/local/keys/.git
RUN sed -i 's/https:\/\/github.com\//git@github.com:/' /usr/local/keys/.git/config

RUN chmod 755 /start.sh
EXPOSE 80
CMD ["/bin/bash", "/start.sh"]
