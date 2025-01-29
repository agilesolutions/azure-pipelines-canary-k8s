# Use a canary deployment strategy for Kubernetes

You use the associated workflow to deploy the code and compare the baseline and canary app deployments. Based on the evaluation, you decide whether to promote or reject the canary deployment.

This tutorial uses Docker Registry and Azure Resource Manager service connections to connect to Azure resources. For an Azure Kubernetes Service (AKS) private cluster or a cluster that has local accounts disabled, an Azure Resource Manager service connections is a better way to connect.

# Prerequisites

## create resource group
```
az group create --name aks-cluster-template_rg001 --location centralus
```

## Create template spec and form
```
az ts create --name clusterspec --version 1 --resource-group tks-cluster-template_rg001 --location centralus  --template-file ./arm-templates/azuredeploy.json --ui-form-definition ./ arm-templates/clusterform.json
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

## Bicep

### Decompile ARM template
```
az bicep decompile --file ./arm-templates/azuredeploy.json
```

### Deploy bicep templates
```
az deployment group create --resource-group aks-cluster-template_rg001 --template-file azuredeploy.bicep --parameters dnsPrefix=rob
```

# Blue-Green Deployment
1. **Initialize**: Logs the start of the deployment.
2. **Deploy Update**: Uses Helm to deploy a new version (e.g., `myapp-green`).
3. **Route Traffic**: Updates the Kubernetes service selector to point to `myapp-green`.
4. **Test Updated Version**: Runs tests to verify the new deployment.
5. **Rollback**: If tests fail, traffic is routed back to `myapp-blue`, and the old version is restored.

## References
- [Tutorial: Use a canary deployment strategy for Kubernetes](https://learn.microsoft.com/en-us/azure/devops/pipelines/ecosystems/kubernetes/canary-demo?view=azure-devops&tabs=yaml)



