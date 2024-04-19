#!/usr/bin/env bash

set -Eeuo pipefail

# Coordinates in GitHub.
ORG_NAME="${ORG_NAME:-cardil}"

source "$(go run knative.dev/hack/cmd/script release.sh)"

build_dir="${BUILD_DIR:-${REPO_ROOT_DIR}/build/_output}"

function build_release {
  export ARTIFACTS_TO_PUBLISH
  go build -o "${build_dir}/placeholder" "${REPO_ROOT_DIR}/cmd/placeholder"
  echo "${build_dir}/placeholder" >> "${build_dir}/artifacts.list"
  GOARCH=arm64 go build -o "${build_dir}/placeholder-arm64" "${REPO_ROOT_DIR}/cmd/placeholder"
  echo "${build_dir}/placeholder-arm64" >> "${build_dir}/artifacts.list"
  ARTIFACTS_TO_PUBLISH="$(tr '\r\n' ' ' < "${build_dir}/artifacts.list")"
  calculate_checksums
}

function calculate_checksums {
  local checksums file
  checksums="${build_dir}/checksums.txt"
  rm -vf "${checksums}"
  while read -r file; do
    pushd "$(dirname "$file")" >/dev/null
    sha256sum "$(basename "$file")" >> "${checksums}"
    popd >/dev/null
  done < "${build_dir}/artifacts.list"
  ARTIFACTS_TO_PUBLISH="${ARTIFACTS_TO_PUBLISH} ${checksums}"
}

main "$@"