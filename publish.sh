#! /bin/bash

hyde gen -r -c prod.yaml

echo "Commit message: "

read message

hyde publish -p github -c prod.yaml -m "$message"
