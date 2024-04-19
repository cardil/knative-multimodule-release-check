module github.com/cardil/knative-multimodule-release-check

go 1.21

require (
	github.com/cardil/knative-multimodule-release-check/pkg/plugin v0.0.0
)

replace github.com/cardil/knative-multimodule-release-check/pkg/plugin => ./pkg/plugin
