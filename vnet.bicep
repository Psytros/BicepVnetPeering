param vnetname string
param vnetlocation string

param vnetAddressPrefix string
param vnetDefaultSubnetPrefix string
param vnetGatewaySubnetPrefix string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vnetname
  location: vnetlocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: 'Default'
        properties: {
          addressPrefix: vnetDefaultSubnetPrefix
        }
      }
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: vnetGatewaySubnetPrefix
        }
      }
    ]
  }
}
