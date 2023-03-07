FROM amazon/aws-lambda-python:3.9

ENV LIB_DIR=/sigv4-layer/packages
RUN mkdir -p ${LIB_DIR}/python
WORKDIR /sigv4-layer/packages

RUN yum install -y zip

RUN python3 -m venv ${LIB_DIR}
RUN source ${LIB_DIR}/bin/activate

WORKDIR ${LIB_DIR}/python

ADD requirements.txt .

RUN pip3 install -r requirements.txt -t .

RUN rm -rf *dist-info
WORKDIR ${LIB_DIR}

RUN zip -r /sigv4-layer/sigv4-layer.zip python

#aws lambda publish-layer-version --layer-name sigv4-layer --zip-file fileb:///sigv4-layer.zip