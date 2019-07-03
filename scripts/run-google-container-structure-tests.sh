#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
[[ "${DEBUG:=false}" == 'true' ]] && set -o xtrace

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly NC='\033[0m' # No Color

log() {
  echo -e "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*"
}

build-googlecst() {
  log "START:${FUNCNAME[0]}"
  printf "${GREEN}building Google Container Structure Tests docker image${NC}\n"
  docker build --tag sweetcount/googlecst:latest -f dockerfiles/Dockerfile-googlecst .
}

test-googlecst() {
  log "START:${FUNCNAME[0]}"
	docker run \
		--volume $(pwd)/dockerfiles/googlecst-tests.yml:/test-config/"${FUNCNAME[0]}".yml \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--workdir /test-config/ \
		sweetcount/googlecst:latest \
		test --image sweetcount/googlecst:test --config "${FUNCNAME[0]}".yml
}

build-newman() {
  log "START:${FUNCNAME[0]}"
  cd dockerfiles;
  docker build --tag sweetcount/newman:test -f Dockerfile-newman .
}

test-newman() {
  log "START:${FUNCNAME[0]}"
  docker run \
    --volume $(pwd)/dockerfiles/newman-tests.yml:/test-config/"${FUNCNAME[0]}".yaml \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --workdir /test-config/ \
    sweetcount/googlecst:latest \
    test --image sweetcount/newman:test --config "${FUNCNAME[0]}".yaml
}

build-sweetcount() {
  log "START:${FUNCNAME[0]}"
  docker build  --tag sweetcount/app:test .
}

test-sweetcount() {
  log "START:${FUNCNAME[0]}"
  docker run \
    --volume $(pwd)/dockerfiles/sweetcount-tests.yml:/test-config/"${FUNCNAME[0]}".yaml \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --workdir /test-config/ \
    sweetcount/googlecst:latest \
    test --image sweetcount/app:test --config "${FUNCNAME[0]}".yaml
}

main() {
  st=$(date +%s)
  build-googlecst &
  test-googlecst &
  wait
  build-newman &
  build-sweetcount &
  wait
  printf "${GREEN}#########################################${NC}\n"
  printf "${GREEN}Starting Google Container Structure Tests${NC}\n"
  printf "${GREEN}#########################################${NC}\n"
  test-newman
  test-sweetcount
  et=$(date +%s)
  log "${GREEN}Total Elasped: $((et - st)) seconds${NC}"
}

main "$@"
