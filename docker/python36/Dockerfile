FROM python:3.6-bullseye

RUN apt update

RUN apt install locales -y && \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt install -y jq less git vim curl wget sudo tmux

RUN pip install --upgrade pip

RUN groupadd sysadmin && echo "%sysadmin ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/sysadmin

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh
CMD ["/usr/local/bin/entrypoint.sh"]
