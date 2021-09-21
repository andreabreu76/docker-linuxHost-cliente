FROM debian:latest

LABEL maintainer="andre.abreu@gmail.com"
LABEL version="0.1"
LABEL description="Este é um Linux para desenvolvimento"

#ARG DEBIAN_FRONTEND=noninteractive
ARG HOSTNAME=yourClientName
ARG USER=yourUserName
ARG USERNAME="Your Name"
ARG USERMAIL="Your email address"
ARG PASSWORD="A basic password"

# Basics
RUN apt update && apt -y upgrade 
RUN apt install -y curl vim wget git ssh zsh unzip gzip sudo openssh-server

# PHP
RUN apt install -y php7.4-common \
    php7.4-fpm \
    php7.4-gd \
    php7.4-mysql \
    php7.4-curl \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-bcmath \
    php7.4-imap \
    php7.4-xml \
    php7.4-zip \
    libmcrypt-dev \
    php-tokenizer \
    libmagickwand-dev

# NODE
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# COMPOSER
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer

# LARAVEL
RUN composer global require laravel/installer
RUN export PATH=$PATH:$HOME/.composer/vendor/bin

# AWS CLI2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Kubernets
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Golang
RUN curl -LO https://golang.org/dl/go1.17.1.linux-amd64.tar.gz  && \
    tar -C /usr/local -xzf go1.17.1.linux-amd64.tar.gz && \ 
    echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/skel/.bashrc && \
    rm go1.17.1.linux-amd64.tar.gz

# Powerline
RUN apt install -y fonts-powerline fonts-cascadia-code fonts-firacode powerline powerline-gitstatus python3-powerline vim-airline

# Git defaults
RUN git config --global user.name ${USERNAME} && \
    git config --global user.email ${USERMAIL} && \
    git config --global color.ui auto && \
    git config --global merge.conflictstyle diff3 && \
    git config --global core.editor "vim"

RUN echo "%adm  ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
COPY conf/powerline.conf /etc/bash_completion.d/powerline
RUN cat /etc/bash_completion.d/powerline >> /etc/skel/.bashrc

#ADD USER
RUN adduser --disabled-password --gecos "" --shell /bin/bash ${USER}
RUN usermod -a -G adm ${USER}
RUN usermod -a -G sudo ${USER}
RUN passwd -d ${USER}
RUN chown -R ${USER}:${USER} /home/${USER}/

WORKDIR /home/${USER}
USER ${USER}
