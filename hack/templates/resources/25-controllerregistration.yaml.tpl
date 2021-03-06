<%
  import os, yaml

  values={}
  if context.get("values", "") != "":
    values=yaml.load(open(context.get("values", "")), Loader=yaml.Loader)

  def value(path, default):
    keys=str.split(path, ".")
    root=values
    for key in keys:
      if isinstance(root, dict):
        if key in root:
          root=root[key]
        else:
          return default
      else:
        return default
    return root
%># ControllerRegistration object allows to register external controllers.
# See https://github.com/gardener/gardener/blob/master/docs/proposals/01-extensibility.md.
---
apiVersion: core.gardener.cloud/v1beta1
kind: ControllerRegistration
metadata:
  name: ${value("metadata.name", "os-coreos")}<% annotations = value("metadata.annotations", {}); labels = value("metadata.labels", {}) %>
  % if annotations != {}:
  annotations: ${yaml.dump(annotations, width=10000, default_flow_style=None)}
  % endif
  % if labels != {}:
  labels: ${yaml.dump(labels, width=10000, default_flow_style=None)}
  % endif
spec:
  resources:
  - kind: OperatingSystemConfig
    type: coreos
  deployment:
    type: helm
    providerConfig:
      chart: |
        H4sIFAAAAAAA/yk...
      values:
        foo: bar
