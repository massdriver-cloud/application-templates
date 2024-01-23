{{/*
Since this is a template chart, the chart name will be filled in by the user and is the primary naming field.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "application.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "application.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "application.labels" -}}
{{ include "application.selectorLabels" . }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
app.kubernetes.io/chart: {{ include "application.chart" . }}
app.kubernetes.io/deployed-with: massdriver.cloud
{{- end }}

{{/*
Selector labels
*/}}
{{- define "application.selectorLabels" -}}
app.kubernetes.io/name: {{ include "application.fullname" . }}
{{- end }}

{{/*
Pod labels
*/}}
{{- define "application.podLabels" -}}
{{ include "application.labels" . }}
{{- with .Values.pod.labels }}
{{ toYaml . }}
{{- end }}
{{- end }}
