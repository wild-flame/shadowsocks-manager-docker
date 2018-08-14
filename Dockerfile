FROM ubuntu:16.04

ADD sources.list /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y tzdata curl supervisor software-properties-common python-software-properties && \
    add-apt-repository ppa:max-c-lv/shadowsocks-libev && apt-get update && \
    apt-get install -y shadowsocks-libev && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata    

# RUN npm i -g shadowsocks-manager --unsafe-perm

# ADD [--chown=<user>:<group>] <src>... <dest> 
# The ADD instruction copies new files, directories or remote file URLs from <src> and adds them to the filesystem of the image at the path <dest>.

ADD code /var/www/shadowsocks-manager 
ADD config /etc/shadowsocks
ADD supervisor /etc/supervisor
ADD entry.sh .

ENTRYPOINT ["bash", "./entry.sh"]
