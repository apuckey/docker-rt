FROM phusion/baseimage:0.9.17

ADD http://s3-repository.rawideas.com/packages/gpg.key /root/
RUN echo "deb http://s3-repository.rawideas.com/packages trusty main" > /etc/apt/sources.list.d/rawideas.trusty.list

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-key add /root/gpg.key && \
      apt-get update && apt-get -q -y install --no-install-recommends \
      postfix \
      git \
      build-essential \
      nginx-full \
      request-tracker4 \
      rt4-fcgi \
      rt4-db-mysql \
      spawn-fcgi \
      procmail \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

ADD ./scripts/rtcron /usr/bin/rtcron
ADD ./scripts/rtinit /usr/bin/rtinit
ADD ./scripts/rtupgrade /usr/bin/rtupgrade
ADD ./etc/crontab.root /var/spool/cron/crontabs/root

COPY etc/ /etc/
COPY RT_SiteConfig.pm /etc/request-tracker4/RT_SiteConfig.pm

# Configure Postfix
RUN chown -R root:root /etc/postfix
RUN newaliases
RUN mkdir -m 1777 /var/log/procmail

ADD ./scripts/installext.sh /usr/local/bin/installext.sh
RUN chmod +x /usr/local/bin/installext.sh

RUN /usr/local/bin/installext.sh https://github.com/bestpractical/rt-extension-mergeusers
RUN /usr/local/bin/installext.sh https://github.com/bestpractical/rt-extension-jsgantt
RUN /usr/local/bin/installext.sh https://github.com/bestpractical/rt-extension-resetpassword
RUN /usr/local/bin/installext.sh https://github.com/bestpractical/rt-extension-activityreports
RUN /usr/local/bin/installext.sh https://github.com/bestpractical/rt-extension-spawnlinkedticketinqueue
RUN /usr/local/bin/installext.sh https://github.com/bestpractical/rt-extension-commandbymail
RUN /usr/local/bin/installext.sh https://github.com/bestpractical/rt-extension-repeatticket
RUN cp /usr/src/rt-extension-repeatticket/bin/rt-repeat-ticket /usr/sbin

VOLUME ["/var/lib/request-tracker4"]
EXPOSE 80
EXPOSE 25

CMD ["/sbin/my_init"]
