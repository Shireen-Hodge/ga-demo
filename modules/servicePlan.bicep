param namePrefix string
param location string = resourceGroup().location
param sku string = 'B1'

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: '${namePrefix}-website'
  location: location
  kind: 'ubuntu'
  sku:{
    name: sku
  }
  //properties: {
    //reserved: true
  //}


}
output planid string = appServicePlan.id
