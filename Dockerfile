FROM joshuacox/gitreceive
MAINTAINER Josh Cox <josh 'at' webhosting.coop>

ENV DEBIAN_FRONTEND noninteractive

ADD ./start.sh /start.sh

ENV TARGETUSER user1
ENV TARGETREPO https://github.com/WebHostingCoopTeam/keys.git
# RUN cd /usr/local ; git clone $TARGETREPO keys
# RUN cd /usr/local/keys/.git
# RUN sed -i 's/https:\/\/github.com\//git@github.com:/' /usr/local/keys/.git/config

RUN chmod 755 /start.sh
EXPOSE 80
CMD ["/bin/bash", "/start.sh"]
