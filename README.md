# azure-aks-service-mesh

## infra
### terraform
prerequisites:
- azure cli
- terraform
- istio CLI

Login to Azure:
```
az login
```
Get id from output and create service principal:
```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<the id output from the az login command>"
```
Set the following outputs to the following environment variables
- `appId to` `ARM_CLIENT_ID`
- `password` to `ARM_CLIENT_SECRET`
- `tenant` to `ARM_TENANT_ID`
- `id` output from `az login` to `ARM_SUBSCRIPTION_ID`

Deploy:
```
terraform init
terraform apply -auto-approve
```
Update kubernetes context:
```
az aks get-credentials --name $(terraform output aks_name | sed 's/"//g') --overwrite-existing --resource-group $(terraform output resource_group_name | sed 's/"//g')
```

## TODO
- test the service mesh with the bookinfo example
- add documentation about service-mesh in the README
- update the existing documentation about installation and demo

## sources
https://istio.io/latest/docs/setup/getting-started/#install
https://istio.io/latest/docs/examples/bookinfo/
https://www.linkedin.com/pulse/azure-kubernetes-service-aks-istio-mesh-comprehensive-cristofolini
https://learn.microsoft.com/en-us/azure/aks/istio-deploy-addon