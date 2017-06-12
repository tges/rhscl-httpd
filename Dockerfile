## web server for ajp connect to backend jboss eap64/70
## 2017.04.04 by Yun Insu ora01000@time-gate.com


FROM rhscl/httpd-24-rhel7:latest

MAINTAINER ora01000@time-gate.com

COPY net-tools-2.0-0.17.20131004git.el7.x86_64.rpm /tmp
RUN rpm -ivh /tmp/net-tools-2.0-0.17.20131004git.el7.x86_64.rpm

## for debug
# COPY ./dummy.sh /tmp
# RUN chmod 755 /tmp/dummy.sh
# ENTRYPOINT ["/tmp/dummy.sh"]


USER 1001
#USER 0

 
