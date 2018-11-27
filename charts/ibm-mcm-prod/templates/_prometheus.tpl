{{/* Prometheus Configuration Files */}}
{{- define "prometheusConfig" }}
prometheus.yml: |-
  global:
    scrape_interval: 1m
    scrape_timeout: 30s
    evaluation_interval: 1m
  alerting:
    alertmanagers:
    - static_configs:
      - targets: []
      scheme: http
      timeout: 10s
  scrape_configs:
{{- end }}
