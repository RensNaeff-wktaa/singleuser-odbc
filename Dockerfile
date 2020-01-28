FROM jupyterhub/k8s-singleuser-sample:0.8.2

USER root
RUN apt-get update \
        && apt-get install -y curl apt-transport-https gnupg2 \
        && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
        && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
        && apt-get update \
        && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools \
        && apt-get install unixodbc-dev -y \
        ##&& echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
        && ln -s /opt/mssql-tools/bin/* /usr/local/bin/ \
        && apt-get install python -y \
        && apt-get install python-pip -y \
        && apt-get install gcc -y \
        && apt-get install g++ -y \
        && apt-get install build-essential \
        && pip install pyodbc

USER jovyan
