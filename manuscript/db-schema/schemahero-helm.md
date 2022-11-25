# Manage DB Schema With SchemaHero With Helm

TODO: Intro

## Setup

* Install `krew` from https://krew.sigs.k8s.io/docs/user-guide/setup/install

```bash
kubectl krew install schemahero

kubectl schemahero install
```

## Do

```bash
kubectl --namespace dev exec --stdin --tty \
    cncf-demo-postgresql-0 -- psql --dbname postgres \
    --username postgres

# Password: postgres

CREATE DATABASE "cncf-demo";

exit

cat helm/app/templates/postgresql.yaml

cat helm/app/values.yaml

yq --inplace ".schemahero.enabled = true" helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev --wait

curl "https://dev.cncf-demo.$DOMAIN/videos"

curl -X POST "https://dev.cncf-demo.$DOMAIN/video?id=wNBG1-PSYmE&title=Kubernetes%20Policies%20And%20Governance%20-%20Ask%20Me%20Anything%20With%20Jim%20Bugwadia"

curl -X POST "https://dev.cncf-demo.$DOMAIN/video?id=VlBiLFaSi7Y&title=Scaleway%20-%20Everything%20We%20Expect%20From%20A%20Cloud%20Computing%20Service%3F"

curl "https://dev.cncf-demo.$DOMAIN/videos" | jq .
```

## Continue The Adventure

[TODO:](TODO:)

## Undo The Changes

Execute the commands that follow **ONLY** if you want to change your mind and go back.

```bash
yq --inplace ".schemahero.enabled = false" helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev --wait

kubectl --namespace dev exec --stdin --tty \
    cncf-demo-postgresql-0 -- psql --dbname postgres \
    --username postgres

# Password: postgres

DROP DATABASE "cncf-demo";

exit
```