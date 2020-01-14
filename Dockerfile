FROM ubuntu:16.04
MAINTAINER Silipwn <silipwned@gmail.com>

# Addding local repos for faster downloads :)
RUN echo "deb [arch=amd64] http://ubuntu.amrita.ac.in/ubuntu/ bionic main universe multiverse restricted \n deb [arch=amd64] http://ubuntu.amrita.ac.in/ubuntu/ bionic-updates main universe multiverse restricted \n deb [arch=amd64] http://ubuntu.amrita.ac.in/ubuntu/ bionic-security main universe multiverse restricted" > /etc/apt/sources.list

RUN apt-get update -y
RUN apt-get install -y debconf build-essential \
nano vim git htop wget curl unzip zsh sudo 

RUN \
    groupadd -g 999 user && useradd -u 999 -g user -G sudo -m -s /bin/zsh user && \
    sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g' && \
    echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "Customized the sudoers file for passwordless access to the user user!" && \
    echo "user user:";  su - user -c id

USER user
WORKDIR "/home/user"
# get grml zshrc
RUN wget -O ~/.zshrc http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

ENTRYPOINT zsh 
