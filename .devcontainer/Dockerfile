ARG BASE_IMAGE
# Using my base rapids-dask-pytorch container
FROM ${BASE_IMAGE}:py38-cuda10.2-rapids0.18-pytorch1.7-ubi8

# Labels
LABEL maintainer="Don Chesworth<donald.chesworth@gmail.com>"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="dev_container"
LABEL org.label-schema.description="a development container for pytorch-quik"

ENV PATH="/opt/conda/envs/rdp/bin:/opt/conda/bin:$PATH"
ENV IPYTHONDIR="/opt/rdp/.ipythondir/"

SHELL ["/bin/bash", "-c"]

RUN yum install git -y

RUN source /opt/conda/bin/activate && conda activate rdp && \
    conda install --name rdp ipykernel -y

COPY requirements/ /tmp/
RUN for reqfile in /tmp/*.txt; \
        do pip install -r $reqfile; \
    done
RUN pip install flake8 black

COPY .netrc /root/.netrc
RUN chmod 600 /root/.netrc
COPY pip.conf /opt/rdp/
ENV PIP_CONFIG_FILE="/opt/rdp/pip.conf"

RUN pip install ceean_connectors[vault]

RUN ipython profile create
