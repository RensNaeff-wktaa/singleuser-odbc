FROM jupyterhub/k8s-singleuser-sample:0.10.2

USER root
RUN apt-get update \
        && apt-get install -y curl apt-transport-https gnupg2 \
        && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
        && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
        && apt-get update \
        && wget http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1.3_amd64.deb \
        && apt-get install ./multiarch-support_2.27-3ubuntu1.3_amd64.deb -y \
        ##&& apt-get install unixodbc odbcinst1debian2 multiarch-support libodbc1 -y \
        && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools \
        && apt-get install unixodbc-dev -y \
        ##&& echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
        && ln -s /opt/mssql-tools/bin/* /usr/local/bin/ \
        && apt-get install python3 -y \
        && apt-get install python3-pip -y \
        && apt-get install gcc -y \
        && apt-get install g++ -y \
        && apt-get install build-essential -y \
        && pip install pyodbc

USER jovyan
