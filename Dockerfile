FROM python:3.5

# Standard set up Nginx
RUN pip install uwsgi
ENV NGINX_VERSION 1.9.11-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
    && echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y ca-certificates wget nginx=${NGINX_VERSION} gettext-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Put pretrained models under /usr/share/models
RUN cd /usr/share && mkdir models && cd models && touch trump.ckpt && \
    wget https://s3.amazonaws.com/cadl/models/trump.ckpt.data-00000-of-00001 && \
    wget https://s3.amazonaws.com/cadl/models/trump.ckpt.meta && \
    wget https://s3.amazonaws.com/cadl/models/trump.ckpt.index && \
    wget https://s3.amazonaws.com/cadl/models/trump.txt

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

# Make NGINX run on the foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Remove default configuration from Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copy the modified Nginx conf
COPY nginx.conf /etc/nginx/conf.d/

# Copy the base uWSGI ini file to enable default dynamic uwsgi process number
COPY uwsgi.ini /etc/uwsgi/

# Install Supervisord
RUN apt-get update && apt-get install -y supervisor \
	&& rm -rf /var/lib/apt/lists/*

# Custom Supervisord config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN pip install numpy
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

COPY app /app
WORKDIR /app

CMD ["/usr/bin/supervisord"]
