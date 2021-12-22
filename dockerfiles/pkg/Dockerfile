FROM rocker/rstudio:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
 libxml2-dev \
 libcairo2-dev \
 libsqlite3-dev \
 libmariadb-dev \
 libpq-dev \
 libssh2-1-dev \
 unixodbc-dev \
 libcurl4-openssl-dev \
 libssl-dev

RUN apt-get update && apt-get install -y dos2unix

#COPY install_packages.R /install_packages.R

RUN dos2unix /install_packages.R \
 && Rscript /install_packages.R
