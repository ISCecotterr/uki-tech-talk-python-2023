ARG IMAGE=containers.intersystems.com/intersystems/iris:2023.1.0.235.1

FROM ${IMAGE}
USER root
WORKDIR /opt

RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-venv \
    sudo && \
    /bin/echo -e ${ISC_PACKAGE_MGRUSER}\\tALL=\(ALL\)\\tNOPASSWD: ALL >> /etc/sudoers && \
	sudo -u ${ISC_PACKAGE_MGRUSER} sudo echo enabled passwordless sudo-ing for ${ISC_PACKAGE_MGRUSER}

RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt
USER ${ISC_PACKAGE_MGRUSER}

COPY irisapp /opt/irisapp
COPY webapp /opt/webapp
COPY cubeapp /opt/cubeapp
COPY requirements.txt /opt/requirements.txt
COPY iris.key /opt/iris.key
COPY iris.script /opt/iris.script

# Start IRIS and load demo
RUN iris start IRIS \
	&& iris session IRIS < /opt/iris.script && iris stop IRIS quietly

# Create Python environment
ENV PYTHON_PATH=/usr/irissys/bin/irispython
ENV IRISUSERNAME "SuperUser"
ENV IRISPASSWORD "SYS"
ENV IRISNAMESPACE "USER"

RUN python3 -m venv /opt
COPY intersystems_irispython-3.2.0-py3-none-any.whl /opt/intersystems_irispython-3.2.0-py3-none-any.whl
RUN /opt/bin/pip install --upgrade -r /opt/requirements.txt
RUN /opt/bin/pip install /opt/intersystems_irispython-3.2.0-py3-none-any.whl
# Slightly modified Director class due to occasional issues with business service instantiation.
COPY misc/override/_Director.py /opt/lib/python3.10/site-packages/iris/pex/_Director.py
# CMD ["/opt/bin/python", "webapp/flask_app.py"]