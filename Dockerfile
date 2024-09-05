# The same Dockerfile can be used to create a different image based on that specified at the top, which is production
# In this scenario a development image (see further down) will be created based on the production
# A Dockerfile runs sequentially so the development image will overwrite the production
# Run this file directly or use the make file to target just production, or production and development which will build development

# Specify a base image
# production is a tag
FROM python:3-slim as production

# Each one of the steps below is cached, so if nothing is changed then they remain the same
# Set an environment variable
ENV PYTHONUNBUFFERED=1
# Set the working directory. Whenever files are referenced further down, they will be in this directory
WORKDIR /app/

ARG CACHEBUST=1

#RUN apt-get update && \
#    apt-get install -y \
#    bash \
#    build-essential \
#    gcc \
#    libffi-dev \
#    musl-dev \
#    openssl \
#    postgresql \
#    libpq-dev

# Copy files from local file system to the Docker image
COPY requirements/prod.txt ./requirements/prod.txt
# Install dependancies in the Docker image
RUN pip install -r ./requirements/prod.txt

# It is possible to copy everything into the Docker image using COPY . .
# However since this is production we don't want to copy everything, only what we need
# Copy more files from local file system to the Docker image
COPY manage.py ./manage.py
COPY setup.cfg ./setup.cfg
# Copy the main app directory
COPY hackershack_website ./hackershack_website

# Expose the port that this Docker image will be running
EXPOSE 8000


FROM production as development

COPY requirements/dev.txt ./requirements/dev.txt
RUN pip install -r ./requirements/dev.txt

# Copy all files from local file system to the Docker image
COPY . .
