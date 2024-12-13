FROM nvidia/cuda:12.2.0-runtime-ubuntu20.04

ENV POETRY_VERSION=1.8.3
ENV DEBIAN_FRONTEND=noninteractive

# Add PPA for Python 3.10
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    curl \
    gdal-bin \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Ensure python3 and python both point to python3.10
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 \
    && ln -s /usr/bin/python3.10 /usr/bin/python

# Install a clean version of pip using get-pip.py
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py && rm get-pip.py

# Install Poetry
RUN pip install "poetry==$POETRY_VERSION"

WORKDIR /popcorn

# Install environment
COPY pyproject.toml poetry.lock /popcorn
RUN poetry config virtualenvs.create false
RUN poetry install --no-interaction

# Copy source code
COPY ./popcorn /popcorn/popcorn/
RUN mkdir /inputs /outputs

# Entry point for the container
ENTRYPOINT ["poetry", "run", "python", "popcorn/run_eval.py"]
