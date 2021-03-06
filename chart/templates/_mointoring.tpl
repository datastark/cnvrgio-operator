{{- define "spec.monitoring" }}
monitoring:
{{- /*
    The prometheus.enabled is depricated, and will be removed in the future.
    instaed, use --set monitoring.enabled=<"true"|"false">
*/ -}}
  {{- if .Values.prometheus }}
    {{- if .Values.prometheus.enabled }}
        {{- if eq (.Values.prometheus.enabled | toString) "true" }}
  enabled: "true"
        {{- else }}
  enabled: "false"
        {{- end }}
    {{- else }}
  enabled: "false"
    {{- end }}
  {{- else }}
  enabled: "{{ .Values.monitoring.enabled}}"
  {{- end }}
  prometheusOperator:
    enabled: "{{ .Values.monitoring.prometheusOperator.enabled }}"
    images:
      operatorImage: "{{ .Values.monitoring.prometheusOperator.images.operatorImage }}"
      configReloaderImage: "{{ .Values.monitoring.prometheusOperator.images.configReloaderImage }}"
      prometheusConfigReloaderImage: "{{ .Values.monitoring.prometheusOperator.images.prometheusConfigReloaderImage }}"
      kubeRbacProxyImage: "{{ .Values.monitoring.prometheusOperator.images.kubeRbacProxyImage }}"
  prometheus:
    enabled: "{{ .Values.monitoring.prometheus.enabled }}"
    image: "{{ .Values.monitoring.prometheus.image }}"

    {{- if eq .Values.computeProfile "large"}}
    cpuRequest: "{{.Values.computeProfiles.large.prometheus.cpu}}"
    memoryRequest: "{{.Values.computeProfiles.large.prometheus.memory}}"
    storageSize: "{{.Values.computeProfiles.large.storage}}"
    {{- end }}

    {{- if eq .Values.computeProfile "medium"}}
    cpuRequest: "{{.Values.computeProfiles.medium.prometheus.cpu}}"
    memoryRequest: "{{.Values.computeProfiles.medium.prometheus.memory}}"
    storageSize: "{{.Values.computeProfiles.medium.storage}}"
    {{- end }}

    {{- if eq .Values.computeProfile "small"}}
    cpuRequest: "{{.Values.computeProfiles.small.prometheus.cpu}}"
    memoryRequest: "{{.Values.computeProfiles.small.prometheus.memory}}"
    storageSize: "{{.Values.computeProfiles.small.storage}}"
    {{- end }}
    svcName: "{{ .Values.monitoring.prometheus.svcName }}"
    port: "{{ .Values.monitoring.prometheus.port }}"
    nodePort: "{{ .Values.monitoring.prometheus.nodePort }}"
    storageClass: "{{ .Values.monitoring.prometheus.enabled }}"

  nodeExporter:
    enabled: "{{ .Values.monitoring.nodeExporter.enabled }}"
    image: "{{ .Values.monitoring.nodeExporter.image }}"

  kubeStateMetrics:
    enabled: "{{ .Values.monitoring.kubeStateMetrics.enabled }}"
    image: "{{ .Values.monitoring.kubeStateMetrics.image }}"
  grafana:
    enabled: "{{ .Values.monitoring.grafana.enabled }}"
    image: "{{ .Values.monitoring.grafana.image }}"
    svcName: "{{ .Values.monitoring.grafana.svcName }}"
    port: "{{ .Values.monitoring.grafana.port }}"
    nodePort: "{{ .Values.monitoring.grafana.nodePort }}"
  defaultServiceMonitors:
    enabled: "{{ .Values.monitoring.defaultServiceMonitors.enabled }}"
  sidekiqExporter:
    enabled: "{{ .Values.monitoring.sidekiqExporter.enabled }}"
    image: "{{ .Values.monitoring.sidekiqExporter.image }}"
  minioExporter:
    enabled: "{{ .Values.monitoring.minioExporter.enabled }}"
    image: "{{ .Values.monitoring.minioExporter.image }}"
  dcgmExporter:
    enabled: "{{ .Values.monitoring.dcgmExporter.enabled }}"
    image: "{{ .Values.monitoring.dcgmExporter.image }}"
    port: "{{ .Values.monitoring.dcgmExporter.port }}"
  idleMetricsExporter:
    enabled: "{{ .Values.monitoring.idleMetricsExporter.enabled }}"
{{- end }}