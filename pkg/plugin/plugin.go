package plugin

import (
	"k8s.io/utils/diff"
)

type Plugin struct {
	Name string
}

func (p *Plugin) Diff() string {
	return diff.StringDiff(p.Name, "Plugin")
}
