#!/bin/bash

. /common.sh

if ! getent hosts spark-master; then
    echo "=== Cannot resolve the DNS entry for spark-master. Has the service been created yet, and is SkyDNS functional?"
    echo "=== See http://kubernetes.io/v1.1/docs/admin/dns.html for more details on DNS integration."
    echo "=== Sleeping 10s before pod exit."
    sleep 10
    exit 0
fi

# Run spark-class directly so that when it exits (or crashes), the pod restarts.
/opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://spark-master:7077 --webui-port 8081
