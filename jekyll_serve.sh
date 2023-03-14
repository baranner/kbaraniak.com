#! /bin/zsh

cd docker

git pull

docker start jekyll_docker

docker exec -itw "/srv/jekyll" jekyll_docker jekyll serve
