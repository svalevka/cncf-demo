#!/bin/bash
export AWS_PROFILE=coppertest-tooling

aws route53 change-resource-record-sets \
    --hosted-zone-id Z06652871OHS70BQ2P2KO \
    --change-batch '{
        "Changes": [
            {
                "Action": "DELETE",
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
    --profile coppertest-sharedservices

aws route53 change-resource-record-sets \
    --hosted-zone-id Z06652871OHS70BQ2P2KO \
    --change-batch '{
        "Changes": [
            {
                "Action": "DELETE",
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
    --profile coppertest-sharedservices


aws route53 change-resource-record-sets \
    --hosted-zone-id Z06652871OHS70BQ2P2KO \
    --change-batch '{
        "Changes": [
            {
                "Action": "DELETE",
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
    --profile coppertest-sharedservices  --query 'ResourceRecordSets'



eksctl delete cluster -n dot --region eu-west-2

rm -rf kubeconfig-dev.yaml 