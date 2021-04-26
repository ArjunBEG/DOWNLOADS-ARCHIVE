#!/bin/sh
#
# Use this script to generate a Service Architecture
# for your docker-compose.yml file.
#

cd $PATH_TO_COMPOSE_FILE

cat docker-compose.yml | \
    docker run -i funkwerk/compose_plantuml --link-graph --boundaries | \
    docker run -i think/plantuml -tpng > output.png
