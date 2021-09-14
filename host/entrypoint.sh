#!/usr/bin/env bash

# ssh setup
service ssh start
service ssh status

# call given command
exec "${@}"
