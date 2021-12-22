FROM rocker/verse:3.6.1

# Install mssql drivers
RUN apt-get update 
RUN apt-get install -y unixodbc
RUN apt-get install -y libudunits2-dev curl unixodbc-dev gnupg2 apt-transport-https ca-certificates
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools

# Expor mssql-tools variable to bashrc
WORKDIR /home/rstudio/
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> .bashrc

# Install R packages
RUN install2.r --error \
    DBI odbc
