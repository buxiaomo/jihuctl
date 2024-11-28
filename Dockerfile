FROM python:3.10.6

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

WORKDIR /app

RUN ln /usr/bin/python3 /usr/bin/python \
    && make runtime

CMD [ "bash" ]