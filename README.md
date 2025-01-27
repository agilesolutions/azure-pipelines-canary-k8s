# Use a canary deployment strategy for Kubernetes

You use the associated workflow to deploy the code and compare the baseline and canary app deployments. Based on the evaluation, you decide whether to promote or reject the canary deployment.

This tutorial uses Docker Registry and Azure Resource Manager service connections to connect to Azure resources. For an Azure Kubernetes Service (AKS) private cluster or a cluster that has local accounts disabled, an Azure Resource Manager service connections is a better way to connect.

# Prerequisites

## create resource group
```
az group create --name aks-cluster-template_rg001 --location centralus
```

## Portal deploy cluster with custom ARM template
- From portal search for "Deploy a", this will lead you to custom deployment (Deploy from a custom deployment).
- Build your own template...
- upload your custom  template and go for it

## Test cluster
```
az aks get-credentials --resource-group aks-cluster-template_rg001 --name aks101cluster
kubectl get nodes
kubectl describe node
kubectl top node aks-agentpool-14651446-vmss000000
```
## Create Namespaces
```
kubectl create ns dev
kubectl create ns qa
kubectl create ns staging
kubectl create ns prod
```
## Cleanup
```
az group delete --name aks-cluster-template_rg001
```

## References
- [Tutorial: Use a canary deployment strategy for Kubernetes](https://learn.microsoft.com/en-us/azure/devops/pipelines/ecosystems/kubernetes/canary-demo?view=azure-devops&tabs=yaml)



