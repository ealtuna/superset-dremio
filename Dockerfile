FROM preset/superset
USER root
RUN wget https://download.dremio.com/odbc-driver/1.4.2.1003/dremio-odbc-1.4.2.1003-1.x86_64.rpm
RUN apt-get update && apt-get install alien -y
RUN alien dremio-odbc-1.4.2.1003-1.x86_64.rpm
RUN dpkg -i dremio-odbc_1.4.2.1003-2_amd64.deb
RUN apt-get install -y unixodbc-bin && apt-get install -y unixodbc-dev
RUN pip install pyodbc && pip install sqlalchemy_dremio && pip install dremio_client[full]
USER superset
