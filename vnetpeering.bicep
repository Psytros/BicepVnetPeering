param existingLocalVNetName string
param existingRemoteVNetName string

resource peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
  name: '${existingLocalVNetName}/${existingLocalVNetName}-${existingRemoteVNetName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: resourceId('Microsoft.Network/virtualNetworks', existingRemoteVNetName)
    }
  }
}
