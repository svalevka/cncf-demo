# Use HTTPS With cert-manager

You did it! You installed cert-manager during [setup](/manuscript/setup/dev.md) when you used Helm to install cert-manager. You also created an `Issuer` resource when you applied the file [cert-manager/issuer.yaml](/cert-manager/issuer.yaml) to your cluster.

An `Issuer` is a cert-manager custom Kubernetes resource. It tells cert-manager how to connect to a particular CA. cert-manager will obtain certificates from a variety of Issuers, both popular public Issuers as well as private Issuers.



## Setup

* Already installed in the Setup phase.

## How Did You Define Your App?

* [Helm](cert-manager-helm.md)
* [Kustomize](cert-manager-kustomize.md)
* [Carvel](cert-manager-carvel.md)
* [cdk8s](cert-manager-cdk8s.md)