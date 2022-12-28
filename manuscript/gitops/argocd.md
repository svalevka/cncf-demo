# GitOps With Argo CD

TODO: Intro

## Setup

```bash
helm repo add argo https://argoproj.github.io/argo-helm

helm repo update

export REPO_URL=$(git config --get remote.origin.url)

yq --inplace \
    ".spec.source.repoURL = \"$REPO_URL\"" \
    argocd/apps.yaml
```

## Do

```bash
./crossplane/get-kubeconfig-$XP_DESTINATION.sh

cat argocd/helm-values.yaml

helm upgrade --install argocd argo/argo-cd \
    --namespace argocd --create-namespace \
    --values argocd/helm-values.yaml --wait

cat argocd/project.yaml

kubectl apply --filename argocd/project.yaml

cat argocd/apps.yaml

kubectl apply --filename argocd/apps.yaml

ls -1 schema-hero

cat argocd/schema-hero.yaml

cp argocd/schema-hero.yaml infra/.

cat argocd/cert-manager.yaml

cp argocd/cert-manager.yaml infra/.

git add .

git commit -m "Infra"

git push

kubectl --namespace cert-manager get all
```

## Continue The Adventure

[Ingress](../ingress/story.md)