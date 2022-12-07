# Monitoring services in AKS with Prometheus and display them in Grafana

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Deploy Prometheus](#deploy-prometheus)
4. [Deploy Grafana](#deploy-grafana)
5. [Deploy the sample application](#deploy-the-sample-application)
6. [Configure Prometheus to scrape metrics from the sample application](#configure-prometheus-to-scrape-metrics-from-the-sample-application)
7. [Configure Grafana to display the metrics](#configure-grafana-to-display-the-metrics)

## Introduction

This tutorial shows how to monitor services in AKS with Prometheus and display them in Grafana.
Our sample application will be Keycloak, a popular open source identity and access management solution.

## Prerequisites

1. Deployed AKS cluster
2. kubectl installed and configured to connect to the AKS cluster

## Deploy Prometheus

> [!NOTE]
> We use the the Prometheus Pushgateway to push the metrics from the Keycloak container to the Prometheus server. [Prometheus Pushgateway](https://github.com/prometheus/pushgateway)

1. Create a namespace for Prometheus
   ```bash
   kubectl create namespace monitoring
   ```
2. Deploy Prometheus
   [Collect Prometheus metrics from AKS cluster (preview)](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/prometheus-metrics-enable?tabs=azure-portal)
3. Deploy the Prometheus Pushgateway
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: pushgateway
     namespace: monitoring
   spec:
     replicas: 1
     selector:
        matchLabels:
           app: pushgateway
     template:
        metadata:
           labels:
             app: pushgateway
        spec:
           containers:
           - name: pushgateway
             image: prom/pushgateway
             ports:
             - containerPort: 9091
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: pushgateway
     namespace: monitoring
   spec:
     ports:
     - port: 9091
        targetPort: 9091
     selector:
        app: pushgateway
   ```

## Deploy Grafana

[Create an Azure Managed Grafana instance using the Azure portal](https://learn.microsoft.com/en-us/azure/managed-grafana/quickstart-managed-grafana-portal)

## Deploy the sample application

> [!NOTE]
> We use the Keycloak image from the [Aerogear project](https://github.com/aerogear/keycloak-metrics-spi) to enable the metrics endpoint.

> [!NOTE]
> The Keycloak image is not available in the Azure Container Registry. Therefore, we need to build the image locally and push it to our own ACR.

1. Build the customized Keycloak image in your local folder with the following Dockerfile

   ```dockerfile
    FROM quay.io/keycloak/keycloak:latest

    # Add the metrics SPI to the Keycloak image
    RUN curl -sL https://github.com/aerogear/keycloak-metrics-spi/releases/download/2.5.3/keycloak-metrics-spi-2.5.3.jar -o /opt/keycloak/providers/keycloak-metrics-spi-2.5.3.jar
   ```

2. Push it to your ACR

3. Deploy the sample YAML

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
   name: keycloak-metrics
   labels:
       app: keycloak-metrics
   spec:
   ports:
       - name: http
       port: 8080
       targetPort: 8080
   selector:
       app: keycloak
   type: LoadBalancer
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
   name: keycloak-metrics
   labels:
       app: keycloak
   spec:
   replicas: 1
   selector:
       matchLabels:
       app: keycloak
   template:
       metadata:
       labels:
           app: keycloak
       spec:
       containers:
           - name: keycloak
           image: aksprometheusclusterregistry.azurecr.io/metrics-spi-keycloak:latest
           args: ["start-dev"]
           env:
               - name: KEYCLOAK_ADMIN
               value: "admin"
               - name: KEYCLOAK_ADMIN_PASSWORD
               value: "admin"
               - name: KC_PROXY
               value: "edge"
               - name: KC_HEALTH_ENABLED
               value: "true"
               - name: KC_METRICS_ENABLED
               value: "true"
               - name: PROMETHEUS_PUSHGATEWAY_ADDRESS
               value: 10.244.0.19:9091
               - name: PROMETHEUS_GROUPING_KEY_INSTANCE
               value: ENVVALUE:HOSTNAME
               - name: PROMETHEUS_PUSHGATEWAY_JOB
               value: "keycloak-customer1"
           ports:
               - name: http
               containerPort: 8080
           readinessProbe:
               httpGet:
               path: /realms/master
               port: 8080
       imagePullSecrets:
           - name: acr-tom

   ```

## Configure Prometheus to scrape metrics from the sample application

1. Create a Prometheus Config file to scrape the metrics from the sample application
   ```yaml
   global:
     scrape_interval: 15s
     evaluation_interval: 15s
   scrape_configs:
     - job_name: "keycloak"
       scrape_interval: 5s
       metrics_path: /metrics
       static_configs:
         - targets: ["10.244.0.19:9091"]
   ```
2. Validate and apply the Prometheus Config file
   [Create and validate custom configuration file for Prometheus metrics in Azure Monitor (preview)](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/prometheus-metrics-scrape-validate)

## Configure Grafana to display the metrics

Import the Grafana dashboard:
[Sample Dashboard](https://grafana.com/grafana/dashboards/10441-keycloak-metrics-dashboard/)
