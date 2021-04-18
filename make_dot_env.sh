#!/bin/bash
echo -n > .env
echo HOST_UNAME=$(id -un) >> .env
echo HOST_UID=$(id -u) >> .env
echo HOST_GID=$(id -g) >> .env
