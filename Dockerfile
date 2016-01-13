FROM joshuacox/gitreceive
MAINTAINER Josh Cox <josh 'at' webhosting.coop>

ENV DEBIAN_FRONTEND noninteractive
ENV TARGETUSER user1
ENV TARGETREPO ENTER_YOUR_REPO_HERE

COPY ./start.sh /start.sh
RUN chmod 755 /start.sh
CMD ["/bin/bash", "/start.sh"]
