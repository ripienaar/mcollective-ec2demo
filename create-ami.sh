#!/bin/bash

yum install -y net-snmp-libs lm_sensors net-snmp perl-Socket6 nrpe perl-Crypt-DES perl-Digest-SHA1 nagios-plugins perl-Digest-HMAC perl-Net-SNMP xinetd dialog rubygems java-1.6.0-openjdk libselinux-ruby ruby-augeas ruby-shadow git

cd packages

yum -y --nogpgcheck localinstall activemq-5.4.0-2.el5.noarch.rpm mcollective-1.0.0-2.el5.noarch.rpm puppet-2.6.3-0.4.el5.noarch.rpm rubygem-stomp-1.1.6-1.el5.noarch.rpm activemq-info-provider-5.4.0-2.el5.noarch.rpm mcollective-client-1.0.0-2.el5.noarch.rpm facter-1.5.8-1.el5.noarch.rpm mcollective-common-1.0.0-2.el5.noarch.rpm rubygem-rdialog-0.5.0-1.noarch.rpm tanukiwrapper-3.2.3-1jpp.i386.rpm

gem install passmakr-1.0.0.gem

cd ..

cp -rv etc/* /etc/
cp -rv usr/* /usr/
cp -rv opt/* /opt/

cat <<EOT

The EC2 demo has been prepared, bundle and upload it as below:

   # cd /mnt
   # ec2-bundle-vol -d /mnt -k pk-xxx.pem -c cert-xxx.pem -u 481328239245 -r i386
   # ec2-upload-bundle -b mcollective-100-demo -m image.manifest.xml --location EU -a xxx -s xxx

You need to place your EC2 certs in /mnt first
EOT
