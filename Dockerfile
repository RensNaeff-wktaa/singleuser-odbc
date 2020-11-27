FROM jupyterhub/k8s-singleuser-sample:0.10.4

USER root
RUN apt-get update \
        && apt-get install -y curl apt-transport-https gnupg2 \
        && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
        && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
        && curl http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1.3_amd64.deb \
        && apt-get update \
        && apt-get install ./multiarch-support_2.27-3ubuntu1.3_amd64.deb \
        && apt-get update \
        && apt-get install libodbc1 odbcinst1debian2 unixodbc msodbcsql17 mssql-tools unixodbc-dev -y \
        ##&& apt-get install unixodbc -y \
        ##&& apt-get install unixodbc-dev -y \
        ##&& ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools \
        ##&& echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
        && ln -s /opt/mssql-tools/bin/* /usr/local/bin/ \
        && apt-get install python -y \
        && apt-get install python-pip -y \
        && apt-get install gcc -y \
        && apt-get install g++ -y \
        && apt-get install build-essential -y \
        && pip install pyodbc pandas psycopg2-binary simple-salesforce openpyxl pyyaml \
        && pip install cryptography --upgrade 

USER jovyan
