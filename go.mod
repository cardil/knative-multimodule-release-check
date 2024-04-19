module github.com/cardil/knative-multimodule-release-check

go 1.21

require (
	github.com/cardil/knative-multimodule-release-check/pkg/plugin v0.0.0
	knative.dev/hack v0.0.0-20240418013430-9f6c92e9ee3f
)

replace github.com/cardil/knative-multimodule-release-check/pkg/plugin => ./pkg/plugin
