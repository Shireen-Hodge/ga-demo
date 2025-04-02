// param location string = 'uksouth'
// param storageName string = 'gastorage1972'


// resource storageaccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {
//   name: storageName
//   location: location
//   kind: 'StorageV2'
//   sku: {
//     name: 'Premium_LRS'
//   }
// }

param location string = 'uksouth'
param storageName string = 'webappstorage1973'
param namePrefix string = 'shez1972'

param dockerImage string = 'ubuntu/nginx' //'nginxdemos/hello'
param dockerImageTag string = 'latest'

targetScope = 'resourceGroup'

module storage 'Modules/storage.bicep' = {
  name: storageName
  params: {
    storageName: storageName
    location: location
  }
}

module appPlanDeploy 'Modules/servicePlan.bicep' = {
  name: '${namePrefix}-appPlanDeploy'
  params: {
    namePrefix: namePrefix
    location: location

  }
}

module deploywebApp 'Modules/webApp.bicep' = {
  name: '${namePrefix}-deploy-website'
  params:{
    appPlanId: appPlanDeploy.outputs.planid
    dockerImage: dockerImage
    dockerImageTag: dockerImageTag
    location: location
  }

}
output siteUrl string = deploywebApp.outputs.siteUrl
