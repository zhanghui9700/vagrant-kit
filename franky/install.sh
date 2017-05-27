#### repo

echo "" > /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list

echo "nameserver 114.114.114.114" > /etc/resolv.conf

apt-get update -y && apt-get install -y --force-yes vim git salt-master

#### install docker&docker-compose https://docs.docker.com/engine/installation/linux/ubuntu/

apt-get install -y --force-yes linux-image-extra-$(uname -r) linux-image-extra-virtual
apt-get install -y --force-yes apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y && apt-get install -y --force-yes docker-ce

echo 'DOCKER_OPTS="$DOCKER_OPTS --registry-mirror=http://f2d6cb40.m.daocloud.io"' >> /etc/default/docker

service docker restart

wget http://192.168.30.10/pkg/docker-compose-Linux-x86_64  -O /usr/local/bin/docker-compose  && chmod +x /usr/local/bin/docker-compose


#### docker image

wget -qO- http://192.168.30.10/docker/dockerimages/salt-master.tar | docker load
wget -qO- http://192.168.30.10/docker/dockerimages/suninfo_cobbler | docker load

#### source code
echo "192.168.220.247 git.fx-dev.com" >> /etc/hosts
cd /opt/ && git clone http://git.fx-dev.com/fuel-infra/suninfo/franky

wget http://192.168.30.10/docker/bootstrap/initramfs.img -O /opt/franky/bootstrap/initramfs.img
wget http://192.168.30.10/docker/bootstrap/linux -O /opt/franky/bootstrap/linux
wget http://192.168.30.10/docker/bootstrap/root.squashfs -O /opt/franky/bootstrap/root.squashfs


#### bootstrap target os
mkdir -p /opt/franky/srv/salt/os/files && wget http://192.168.30.10/docker/system-qcow2/ubuntu-14.04.3.qcow2 -O /opt/franky/srv/salt/os/files/ubuntu-14.04.3.qcow2
