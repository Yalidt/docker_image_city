FROM ubuntu:bionic

ENV DEB_PACKAGES="sudo nano less git python3-dev python3-pip python3-setuptools nodejs"

RUN apt-get update && apt-get install -y $DEB_PACKAGES && pip3 install --upgrade pip

RUN apt update && apt-get install -y \
	libsm6 libxext6 libxrender-dev nginx supervisor

RUN pip3 install opencv-python
RUN pip3 install scikit-image
RUN pip3 install requests
RUN pip3 install uwsgi

COPY requirements.txt ./requirements.txt
RUN pip3 install -r requirements.txt

RUN useradd --no-create-home nginx

EXPOSE 5000 8888

RUN mkdir /atipicas_city
RUN mkdir /atipicas_city/log

#COPY allianz.cpython-36m-x86_64-linux-gnu.so /atipicas_city
COPY app_city.py /atipicas_city
COPY model_rf /atipicas_city
COPY model_if /atipicas_city
#COPY explainer_rf /atipicas_city
#COPY explainer_if /atipicas_city
#COPY start.sh /atipicas_city

#COPY nginx.conf /etc/nginx/
#COPY flask-site-nginx.conf /etc/nginx/conf.d/
#COPY uwsgi.ini /etc/uwsgi/
#COPY supervisord.conf /etc/

#CMD ["/tf/allianz/start.sh"]
CMD [ "pyhton3", "app_city.py"]
