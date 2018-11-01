# Dockerfile to build a containerised version of RConfig Network Manager

RConfig is a network device backup utility which takes regular config backups of any 
managed switches, routers or firewalls which can be connected to via Telnet or SSH.

This image configures RConfig initially, but in it's 'raw' form, the data it holds
won't persist. So using persistent volumes for the database and config files is needed
if this image is to be used in production.

To be continued...

