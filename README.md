
# Cert-Manager Linode Solver

This adapter allows you to use the popular [Cert-Manager](https://cert-manager.io/) with [Linode DNS Manager](https://www.linode.com/docs/guides/dns-manager/) as ACME DNS01 Challange Provider.

One use-case is to use wildcard certificates with [Let's Encrypt](https://letsencrypt.org/).

It leverages the official [Linode Go Client](https://github.com/linode/linodego)


## Installation

### Linode Webhook Solver

```bash
helm install cert-manager-linode chart/ -n cert-manager
```

### Configure Cert-Manager Cluster Issuer

https://cert-manager.io/docs/configuration/acme/dns01/webhook/

```yaml
apiVersion: cert-manager.io/v1alpha2
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    email: your-email-address
    privateKeySecretRef:
      name: letsencrypt-prod
    server: https://acme-v02.api.letsencrypt.org/directory
    solvers:
      - dns01:
          webhook:
            groupName: acme.cluster.local
            solverName: linode
            config:
              apiKey: your-api-key

```
