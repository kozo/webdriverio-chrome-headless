FROM node

LABEL maintainer="kozo.sakuragawa"

RUN apt-get update \
	&& apt-get install -y --no-install-recommends vim \
	&& apt-get install -y --no-install-recommends unzip \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-get update \
	&& apt-get install -y --no-install-recommends apt-file \
	&& apt-file update \
	&& apt-file search add-apt-repository \
	&& apt-get install -y software-properties-common \
	&& rm -rf /var/lib/apt/lists/*
 

RUN add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
	&& apt-get update \
	&& echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections \
	&& apt-get install -y --no-install-recommends oracle-java8-installer \
	&& rm -rf /var/lib/apt/lists/*

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends google-chrome-stable \
	&& apt-get --only-upgrade install google-chrome-stable \
	&& rm -rf /var/lib/apt/lists/*

RUN wget https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
	&& mkdir /usr/share/fonts/noto \
	&& unzip NotoSansCJKjp-hinted.zip -d /usr/share/fonts/noto \
	&& rm -f NotoSansCJKjp-hinted.zip \
	&& chmod 644 -R /usr/share/fonts/noto \
	&& fc-cache -fv

WORKDIR /app

COPY ./script/entrypoint.sh /script/entrypoint.sh
RUN chmod +x /script/entrypoint.sh

ENTRYPOINT ["/script/entrypoint.sh"]
