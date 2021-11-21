FROM condaforge/mambaforge

ENV DEBIAN_FRONTEND=noninteractive

ARG MY_TOKEN

RUN mkdir -p /opt/app
COPY ./environment.yaml /opt/app/
COPY ./conda-activate.sh /opt/app/
RUN mamba env create --file /opt/app/environment.yaml --force

CMD "python -m http.server 29999"
