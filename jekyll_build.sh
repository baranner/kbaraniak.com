#! /bin/zsh

cd docker

docker start jekyll_docker

docker exec -w "/srv/jekyll" jekyll_docker jekyll build
