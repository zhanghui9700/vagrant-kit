echo "" > /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse" >> /etc/apt/sources.list

### basic library
apt-get update -y
apt-get install -y vim git
apt-get install -y python-pip


mkdir /root/.pip

cat > /root/.pip/pip.conf <<EOF
[global]
index-url=http://mirrors.aliyun.com/pypi/simple/
timeout = 60
require-virtualenv = false
trusted-host = mirrors.aliyun.com
download_cache = ~/.pip/cache

[install]
index-url=http://mirrors.aliyun.com/pypi/simple/
EOF
