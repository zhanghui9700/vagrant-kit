echo "" > /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list

### basic library
apt-get update -y
apt-get install -y vim git
apt-get install -y python-pip

### install apache2
apt-get install -y --force-yes apache2 libapache2-mod-wsgi && mkdir -p /etc/apache2/ssl

# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/ceph-portal.key -out /etc/apache2/ssl/ceph-portal.crt

#### enable apache2 modules
a2enmod ssl
a2enmod rewrite

service apache2 restart

### portal

# git clone ssh://zhanghui@192.168.220.199/~/review/stor-dashboard ./stor-dashboard
# git clone ssh://zhanghui@192.168.220.199/~/review/eonbazaar ./eonbazaar

mkdir /etc/dashboard
mkdir /root/.pip

# scp zhanghui@192.168.220.199:~/247-settings.py /etc/dashboard/settings.py
# scp zhanghui@192.168.220.199:~/.pip/pip.conf /root/.pip/pip.conf

useradd ceph -p Ceph001 -G root -m

apt-get install -y --force-yes libmysqlclient-dev python-dev
mkdir -p /var/log/stor-dashboard && chown -R ceph:ceph /var/log/stor-dashboard
mkdir -p mkdir /var/log/monitor/ && chown -R ceph:ceph /var/log/monitor

# cd /opt/stor-dashboard && python manage.py collectstatic --noinput
