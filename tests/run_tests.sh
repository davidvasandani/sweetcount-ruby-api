#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# quick one liner to get the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo $DIR

if ! [ -x "$(command -v newman)" ]; then
  echo -e "${RED}Error: newman is not installed${NC}" >&2
  echo -e "${RED}Error: Please install with 'npm install -g newman'${NC}" >&2
  exit 1
fi

echo -e "${GREEN}Running tests${NC}"

newman run $DIR/test_collection.json
