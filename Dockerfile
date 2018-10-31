FROM oraclelinux:7-slim
MAINTAINER Melih Savdert
ENV container docker
##enable epel
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
##installpackages
RUN touch /var/lib/rpm/* && yum --enablerepo=ol7_addons -y install openssl-libs which tar unzip nfs-utils sudo selinux-policy firewalld unzip wget net-tools vim xorg-x11-apps.x86_64 ntp
RUN touch /var/lib/rpm/* && yum -y reinstall glibc-common
RUN yum install -y binutils compat-libstdc++-33 compat-libstdc++-33.i686 gcc gcc-c++ glibc glibc.i686 glibc-devel glibc-devel.i686 ksh libgcc libgcc.i686 libstdc++ libstdc++.i686 libstdc++-devel libstdc++-devel.i686 libaio libaio.i686 libaio-devel libaio-devel.i686 libXext libXext.i686 libXtst libXtst.i686 libX11 libX11.i686 libXau libXau.i686 libxcb libxcb.i686 libXi libXi.i686 make sysstat unixODBC unixODBC-devel zlib-devel zlib-devel.i686
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
userdel -r oracle;\
chmod u+s /usr/bin/ping;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
