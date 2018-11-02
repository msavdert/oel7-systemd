FROM oraclelinux:7
MAINTAINER Melih Savdert
ENV container docker
##enable epel
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# Update the operating system
RUN yum -y update
##installpackages
RUN touch /var/lib/rpm/* && yum --enablerepo=epel-testing -y install tar unzip nfs-utils sudo selinux-policy firewalld
RUN touch /var/lib/rpm/* && yum -y reinstall glibc-common
RUN yum -y clean all
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;\
ln -s /usr/lib/systemd/system/systemd-user-sessions.service  /etc/systemd/system/multi-user.target.wants/systemd-user-sessions.service;\
chmod u+s /usr/bin/ping;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
