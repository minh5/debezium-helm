{{- define "common_deployment" }}
        envFrom:
          - configMapRef:
              name: {{ .Release.Name }}-config-env
{{- end -}}