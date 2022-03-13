#!/bin/bash

curr_path=$(pwd)

docker run -it -v $curr_path/groovy_work:/home/groovy/groovy_work groovy_env:latest /bin/sh 
