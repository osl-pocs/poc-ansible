#!/usr/bin/env bash

source activate poc-ansible

if [ $# -ne 0 ]
  then
    exec "${@}"
fi
