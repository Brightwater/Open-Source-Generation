#! /bin/bash
sudo docker run -d --net=host \
       -e HASURA_GRAPHQL_DATABASE_URL=postgres://osg:osg@localhost:5432/app \
       -e HASURA_GRAPHQL_ENABLE_CONSOLE=true \
       hasura/graphql-engine:latest
