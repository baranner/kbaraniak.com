#! /bin/zsh

cd docker

docker start jekyll_docker

docker exec -itw "/srv/jekyll" jekyll_docker jekyll build
