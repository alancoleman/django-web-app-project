{{/*
Expand the name of the chart.
*/}}
{{- define "django-website.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "django-website.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "django-website.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "django-website.labels" -}}
helm.sh/chart: {{ include "django-website.chart" . }}
{{ include "django-website.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "django-website.selectorLabels" -}}
app.kubernetes.io/name: {{ include "django-website.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "django-website.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "django-website.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "django-website.db.env" -}}
- name: POSTGRES_HOST
  value: django-tutorial-postgresql
- name: POSTGRES_DB
  value: {{ .Values.postgresql.postgresqlDatabase }}
- name: POSTGRES_USER
  value: {{ .Values.postgresql.postgresqlUsername }}
{{- if .Values.postgresql.postgresqlPassword }}
- name: POSTGRES_PASSWORD
  value: {{ .Values.postgresql.postgresqlPassword }}
{{- else }}
- name: POSTGRES_PASSWORD
  valueFrom:
    secretKeyRef:
      name: django-tutorial-postgresql
      key: postgresql-password
{{- end }}
{{- end }}
