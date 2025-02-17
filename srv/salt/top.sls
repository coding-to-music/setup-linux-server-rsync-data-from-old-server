base:
  'dev-*':
    - dev.grafana
    - dev.alloy
    - dev.postgres
    - dev.influxdb
    - dev.kafka
    - dev.server_setup
  'staging-*':
    - staging.grafana
    - staging.alloy
    - staging.postgres
    - staging.influxdb
    - staging.kafka
    - staging.server_setup
  'prod-*':
    - production.grafana
    - production.alloy
    - production.postgres
    - production.influxdb
    - production.kafka
    - production.server_setup
