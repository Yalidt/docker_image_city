FROM ubuntu:16.04

ENV JUPYTERLAB_VERSION 3.0.0
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV DEB_PACKAGES="sudo nano less git python3-dev python3-pip python3-setuptools nodejs"

# apt-get and system utilities
RUN apt-get update && apt-get install -y \
    curl apt-utils apt-transport-https debconf-utils gcc build-essential g++-5\
    && rm -rf /var/lib/apt/lists/*

# adding custom MS repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# install SQL Server drivers
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql unixodbc-dev

# install SQL Server tools
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"
    
RUN apt-get update -y && \
  apt-get install python3-pip idle3 -y && \
  pip3 install --no-cache-dir --upgrade pip && \
    
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && echo "America/Mexico_City" > /etc/timezone && apt-get install -y tzdata

RUN groupadd miuser
RUN useradd miuser -g miuser -m -s /bin/bash
RUN echo 'miuser ALL=(ALL:ALL) NOPASSWD:ALL' | (EDITOR='tee -a' visudo)
RUN echo 'miuser:qwerty' | chpasswd
RUN pip3 install jupyter jupyterlab==$JUPYTERLAB_VERSION --upgrade
USER miuser
RUN jupyter notebook --generate-config && sed -i "s/#c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" /home/miuser/.jupyter/jupyter_notebook_config.py
ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]
