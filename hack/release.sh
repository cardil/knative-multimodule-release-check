#!/usr/bin/env bash

#
# Copyright 2024 The Knative Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -Eeuo pipefail

# Coordinates in GitHub.
ORG_NAME="${ORG_NAME:-cardil}"

# shellcheck disable=SC1090
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