FROM preset/superset
USER root
RUN apt-get update -y && apt-get install -y alien
RUN wget https://download.dremio.com/odbc-driver/1.4.2.1003/dremio-odbc-1.4.2.1003-1.x86_64.rpm -P /tmp/
RUN alien -k -i /tmp/dremio-odbc-1.4.2.1003-1.x86_64.rpm --scripts
RUN apt-get install -y unixodbc-bin && apt-get install -y unixodbc-dev
RUN pip install pyodbc && pip install sqlalchemy_dremio && pip install dremio_client[full]
COPY dremio.py /app/superset/db_engine_specs/
USER superset
