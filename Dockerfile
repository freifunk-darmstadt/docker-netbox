FROM python:3.6

WORKDIR /opt/netbox

ARG BRANCH=master
ARG URL=https://github.com/digitalocean/netbox.git
RUN git clone --depth 1 $URL -b $BRANCH .  && \
    apt-get update -qq && apt-get install -y libldap2-dev libsasl2-dev libssl-dev graphviz && \
	pip install gunicorn==17.5 && \
	pip install django-auth-ldap && \
    pip install -r requirements.txt

ADD entrypoint.sh /entrypoint.sh
ADD netbox/configuration.py /opt/netbox/netbox/netbox/configuration.py

ENTRYPOINT [ "/entrypoint.sh" ]

ADD gunicorn/gunicorn_config.py /opt/netbox/
