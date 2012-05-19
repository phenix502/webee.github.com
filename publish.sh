#! /bin/bash

hyde gen -r -c prod.yaml

echo "Commit message: "

#read message
message="publish."

hyde publish -p github -c prod.yaml -m "$message"
