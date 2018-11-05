# Dockerfile to build a containerised version of RConfig Network Manager

RConfig is a network device backup utility which takes regular config backups of any 
managed switches, routers or firewalls which can be connected to via Telnet or SSH.
https://www.rconfig.com

This image configures RConfig initially, but in it's 'raw' form, the data it holds
won't persist. So using persistent volumes for the database and config files is needed
if this image is to be used in production.

To run the container, first clone this repository, navigate to the 'docker-rconfig'
folder, and create the local image:

```
docker build -rm -t local/rconfig .
```

Once completed, you can run the local images:

```
docker run --name rconfig -d -p 80:80 -p 443:443 local/rconfig
```

You can then access the installation page by opening a browser and navigating to:

http://docker-host-ip-address/install/

The database host is 'localhost', default port 3306, database name is 'rconfig', login 'root' and password is currently blank (todo)

Confirm that all settings are correct, (Check Settings button) then click 'Install Database' button. Once finished, click on the
'Final Checks' button and confirm all is well. Then login to the admin page: 

http://docker-host-ip-address/login.php

Default login is 'admin' with password 'admin'

## Persisting data

During installation, after the Docker image has been started, an external database can be specified instead of the one running locally.
This will persist SQL data in one fashion. Additionally, the second line of the docker-compose file referring to rconfig data (home/rconfig)
must be uncommented.

Alternately, uncomment the two lines in the 'docker-compose.yml' file pertaining to persistent data. This will mean SQL and RConfig
static data will both be saved to locations on the host machine, meaning changes made to the running configuration will survive a
container restart. 
