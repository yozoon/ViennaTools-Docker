#!/bin/bash
if [[ ! -z "$1" ]]; then
    docker run -v $(pwd):/mnt/output -it docker-viennaps "/mnt/output/$1"
else
    echo "Please provide the name of the executable as argument."
fi
