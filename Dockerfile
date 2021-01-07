FROM jupyterhub/k8s-singleuser-sample:0.10.2

USER root
RUN apt-get update \
        && apt-get install -y curl apt-transport-https gnupg2 \
        && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
        && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
        && apt-get update \
        && wget http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1.4_amd64.deb \
        && apt-get install ./multiarch-support_2.27-3ubuntu1.4_amd64.deb -y \
        && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools unixodbc-dev \
        && ln -s /opt/mssql-tools/bin/* /usr/local/bin/ \
        && apt-get install python3 python3-pip gcc g++ build-essential -y \
        && pip install pyodbc pandas psycopg2-binary simple-salesforce openpyxl pyyaml \
        && pip install cryptography --upgrade
        
RUN pip install -Iv jupyterlab-git==0.23.2
RUN pip install -Iv nbgitpuller==0.9.0
RUN jupyter lab build
RUN jupyter serverextension enable --py jupyterlab_git --sys-prefix
RUN chmod 777 /home/jovyan

USER jovyan
