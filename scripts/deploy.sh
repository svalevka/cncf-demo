#!/bin/bash

aws sso login --profile coppertest-tooling
export AWS_PROFILE=coppertest-tooling
gh repo set-default

export KUBECONFIG=$PWD/kubeconfig-dev.yaml
yq --inplace ".kubeConfig = \"$PWD/kubeconfig-dev.yaml\"" settings.yaml

eksctl create cluster --name dot --region eu-west-2  --version 1.24 --nodegroup-name primary  --node-type t3.medium --nodes-min 3 --nodes-max 6   --managed --asg-access  --node-private-networking=true


# kubeconfig
aws eks update-kubeconfig --name dot --region eu-west-2

# Install namespace `dev`
kubectl create namespace dev

# Install traefik helm chart
helm upgrade --install traefik traefik --repo https://helm.traefik.io/traefik --namespace traefik --create-namespace --wait

# Get ingress hostname
export INGRESS_HOSTNAME=$(kubectl --namespace traefik  get service traefik  --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")
export INGRESS_HOST=$(dig +short $INGRESS_HOSTNAME) 

# This is the IP address by which you can access applications running in your cluster!
echo $INGRESS_HOST
INGRESS_HOST=$(echo $INGRESS_HOST | tail -n 1)

# add Route53 values
aws route53 change-resource-record-sets \
    --hosted-zone-id Z06652871OHS70BQ2P2KO \
    --change-batch '{
        "Changes": [
            {
                "Action": "CREATE",
                "ResourceRecordSet": {
                    "Name": "harbor.copper-test.com.",
                    "Type": "A",
                    "TTL": 300,
                    "ResourceRecords": [
                        {
                            "Value": "'"$INGRESS_HOST"'"
                        }
                    ]
                }
            }
        ]
    }' \
    --profile coppertest-sharedservices   > /dev/null

aws route53 change-resource-record-sets \
    --hosted-zone-id Z06652871OHS70BQ2P2KO \
    --change-batch '{
        "Changes": [
            {
                "Action": "CREATE",
                "ResourceRecordSet": {
                    "Name": "notary.copper-test.com.",
                    "Type": "A",
                    "TTL": 300,
                    "ResourceRecords": [
                        {
                            "Value": "'"$INGRESS_HOST"'"
                        }
                    ]
                }
            }
        ]
    }' \
    --profile coppertest-sharedservices   > /dev/null


aws route53 change-resource-record-sets \
    --hosted-zone-id Z06652871OHS70BQ2P2KO \
    --change-batch '{
        "Changes": [
            {
                "Action": "CREATE",
                "ResourceRecordSet": {
                    "Name": "cncf-demo-dev.copper-test.com.",
                    "Type": "A",
                    "TTL": 300,
                    "ResourceRecords": [
                        {
                            "Value": "'"$INGRESS_HOST"'"
                        }
                    ]
                }
            }
        ]
    }' \
    --profile coppertest-sharedservices   > /dev/null




# Configure domain
export DOMAIN='copper-test.com'

