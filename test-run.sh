#! /bin/bash

docker_status=$(docker run --rm $1/weather)

if [[ $docker_status == *"You have to register for one at"* ]]; then
  exit 0
else
  exit 1
fi