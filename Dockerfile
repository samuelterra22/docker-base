# ------------------------------------------------------------------------------
# Docker provisioning script for the docker-base image
#
# 	e.g. docker build -t samuelterra/docker-base:version .
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Start with the official Ubuntu 16.04 base image
# ------------------------------------------------------------------------------

FROM ubuntu:16.04

MAINTAINER Samuel Terra <samuelterra22@hotmail.com.com>

# Set correct environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Use Supervisor to run and manage all other services
CMD ["supervisord", "-c", "/etc/supervisord.conf"]

# ------------------------------------------------------------------------------
# Install Ubuntu depencies
# ------------------------------------------------------------------------------

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# ------------------------------------------------------------------------------
# Provision
# ------------------------------------------------------------------------------

RUN mkdir /provision
ADD provision /provision
RUN ["chmod", "+x", "/provision/provision.sh"]
RUN /provision/provision.sh

# ------------------------------------------------------------------------------
# Set locale (support UTF-8 in the container terminal)
# ------------------------------------------------------------------------------

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# ------------------------------------------------------------------------------
# Clean up
# ------------------------------------------------------------------------------

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
