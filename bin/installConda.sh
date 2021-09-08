#!/usr/bin/env bash

curl https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh > miniconda.sh
chmod 755 miniconda.sh
./miniconda.sh

conda install -c conda-forge tmux vim nodejs


