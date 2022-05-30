FROM python:3.8-bullseye

RUN apt update

RUN apt install locales -y && \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#RUN apt install -y jq

RUN pip install --upgrade pip
COPY requirements.txt ./
RUN pip install -r requirements.txt
