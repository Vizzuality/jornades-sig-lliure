FROM mambaorg/micromamba:1.4.3

ARG CONDA_ENV_FILE

COPY --chown=$MAMBA_USER:$MAMBA_USER ${CONDA_ENV_FILE} /tmp/environment.yml

RUN micromamba install -n base --yes --file /tmp/environment.yml && \
    micromamba clean --all --yes

# Otherwise python will not be found
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Jupyter with Docker Compose
EXPOSE 8888
WORKDIR /home/$MAMBA_USER


ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "jupyter", "lab", "--ip=0.0.0.0","--allow-root", "--no-browser"]