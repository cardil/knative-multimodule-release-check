#!/bin/bash

set -Eeuo pipefail

source "$(go run knative.dev/hack/cmd/script library.sh)"

go_update_deps "$@"
