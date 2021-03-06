#!/bin/bash

MCOLLECTIVE_RPM_VERSION="1.2.0-5.el5"
ACTIVEMQ_RPM_VERSION="5.5.0-1.el5"
STOMP_RPM_VERSION="1.1.8-1.el5"
S3_BUCKET_NAME="mcollective-120-demo"

yum clean all
yum makecache

yum install -y net-snmp-libs lm_sensors net-snmp perl-Socket6 nrpe perl-Crypt-DES perl-Digest-SHA1 nagios-plugins nagios-plugins-all perl-Digest-HMAC perl-Net-SNMP xinetd dialog java-1.6.0-openjdk libselinux-ruby ruby-shadow git rubygems

cd packages

yum -y --nogpgcheck localinstall activemq-${ACTIVEMQ_RPM_VERSION}.noarch.rpm mcollective-${MCOLLECTIVE_RPM_VERSION}.noarch.rpm puppet-2.6.3-0.4.el5.noarch.rpm rubygem-stomp-${STOMP_RPM_VERSION}.noarch.rpm activemq-info-provider-${ACTIVEMQ_RPM_VERSION}.noarch.rpm mcollective-client-${MCOLLECTIVE_RPM_VERSION}.noarch.rpm facter-1.5.8-1.el5.noarch.rpm mcollective-common-${MCOLLECTIVE_RPM_VERSION}.noarch.rpm rubygem-rdialog-0.5.0-1.noarch.rpm tanukiwrapper-3.2.3-1jpp.i386.rpm ruby-augeas-0.3.0-1.el5.i386.rpm augeas-0.7.4-1.el5.i386.rpm augeas-libs-0.7.4-1.el5.i386.rpm

gem install passmakr-1.0.0.gem

cd ..

cp -rv etc/* /etc/
cp -rv usr/* /usr/
cp -rv opt/* /opt/
[ -e /var/tmp/mcollective ] && rm -rf /var/tmp/mcollective
[ -e /root/.bash_history ] && rm -rf /root/.bash_history

cat <<EOT

The EC2 demo has been prepared, bundle and upload it as below:

   # cd /mnt
   # ec2-bundle-vol -d /mnt -k pk-xxx.pem -c cert-xxx.pem -u 481328239245 -r i386
   # ec2-upload-bundle -b ${S3_BUCKET_NAME} -m image.manifest.xml --location EU -a xxx -s xxx

You need to place your EC2 certs in /mnt first
EOT
