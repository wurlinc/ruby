#!/usr/bin/env bash

TAG_HOST=""
# if [! -z "$1"]; then
#   TAG_HOST=$1
# fi

run_docker() {
  image_file=$1
  docker_file_name=$(basename $1)
  docker_dir=$(dirname $1)
  docker_tag=ruby$(echo $docker_dir | sed -e 's/\//-/g' | sed -e 's/\.//')
  docker_name=wurl/ruby
  full_tag=${docker_name}:${docker_tag}
  # docker build
  echo "***********"
  echo "** Docker START Building: ${docker_dir} for ${full_tag}"
  pushd $docker_dir >> /dev/null
  docker build --tag=${full_tag} . 
  echo "** Docker DONE Building: ${docker_dir} for ${full_tag}"
  echo "***********"
  popd >> /dev/null
}
export -f run_docker
find . -iname 'Dockerfile' -exec bash -c 'run_docker "$0"' {} \;
