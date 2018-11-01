# Dockerfile to build a containerised version of RConfig Network Manager

RConfig is a network device backup utility which takes regular config backups of any 
managed switches, routers or firewalls which can be connected to via Telnet or SSH.

This image configures RConfig initially, but in it's 'raw' form, the data it holds
won't persist. So using persistent volumes for the database and config files is needed
if this image is to be used in production.

To run the container, first create the local image:

```
docker build -rm -t local/c7-systemd-rconfig .
```

Once completed, you can run the local images:

```
docker run --name rconfig -d -p 80:80 -p 443:443 local/c7-systemd-rconfig
```

You can then access the installation page by opening a browser and navigating to ####http://docker-host-ip-address/install/

The database host is 'localhost', default port 3306, login 'root' and password is currently blank (todo)

Confirm that all settings are correct, then once finished login to the admin page: ####http://docker-host-ip-address/login.php

Default login is 'admin' with password 'admin'
