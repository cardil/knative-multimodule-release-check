module github.com/cardil/knative-multimodule-release-check

go 1.21

require (
	github.com/cardil/knative-multimodule-release-check/pkg/plugin v0.0.0
	knative.dev/hack v0.0.0-20240418013430-9f6c92e9ee3f
)

require (
	github.com/davecgh/go-spew v1.1.1 // indirect
	k8s.io/utils v0.0.0-20240310230437-4693a0247e57 // indirect
)

replace github.com/cardil/knative-multimodule-release-check/pkg/plugin => ./pkg/plugin

replace knative.dev/hack => github.com/cardil/knative-hack v0.0.0-20240424172946-20c61403cfb1
