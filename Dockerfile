FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN yum -y install httpd; yum clean all; systemctl enable httpd.service

# Install the epel and remi repositories
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php72
RUN yum -y update

# Install the PHP components
RUN yum -y install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo

# Install the database server
RUN yum -y install mariadb-server

# Install the openssl and ssl modules
RUN yum -y install openssl mod_ssl

# Enable the database at startup
RUN systemctl enable mariadb.service

# ToDo: Set the root password for mysql prior to build...
# RUN mysqladmin -u root password rconfig

# Copy the rconfig folder to the container
ADD rconfig /home/rconfig

# Copy the Apache configs
ADD httpd/conf /etc/httpd/conf
ADD httpd/conf.d /etc/httpd/conf.d
ADD httpd/conf.modules.d /etc/httpd/conf.modules.d
RUN chown -R apache /home/rconfig

# Create self-signed certificate for the Apache server.
RUN openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=GB/ST=London/L=Greater London/O=localhost/CN=localhost" -keyout /etc/pki/tls/private/localhost.key -out /etc/pki/tls/certs/localhost.crt
# Expose the required ports
EXPOSE 80 443
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
