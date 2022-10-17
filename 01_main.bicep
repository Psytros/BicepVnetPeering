param location string = 'switzerland north'

param mainresourceGroupName string = 'TestMainBicepRG'

param vnetName string = 'VnetBicep'
param vnetAddressPrefix string = '10.230.0.0/16'
param vnetDefaultSubnetPrefix string = '10.230.0.0/24'
param vnetGatewaySubnetPrefix string = '10.230.150.0/24'

param vnetSecondName string = 'VnetBicep2'
param vnetSecondAddressPrefix string = '10.235.0.0/16'
param vnetSecondDefaultSubnetPrefix string = '10.235.0.0/24'
param vnetSecondGatewaySubnetPrefix string = '10.235.150.0/24'

targetScope = 'subscription'

module resgrp 'rg.bicep' = {
  name: mainresourceGroupName
   params: {
    resourceGroupName: mainresourceGroupName
    location: location
  }
}

module vnet 'vnet.bicep' = {
  name: vnetName
  params: {
    vnetname: vnetName
    vnetlocation: location
    vnetAddressPrefix: vnetAddressPrefix
    vnetDefaultSubnetPrefix: vnetDefaultSubnetPrefix
    vnetGatewaySubnetPrefix: vnetGatewaySubnetPrefix
  }
  dependsOn: [
    resgrp
  ]
  scope: resourceGroup(mainresourceGroupName)
}

module vnetSecond 'vnet.bicep' = {
  name: vnetSecondName
  params: {
    vnetname: vnetSecondName
    vnetlocation: location
    vnetAddressPrefix: vnetSecondAddressPrefix
    vnetDefaultSubnetPrefix: vnetSecondDefaultSubnetPrefix
    vnetGatewaySubnetPrefix: vnetSecondGatewaySubnetPrefix
  }
  dependsOn: [
    resgrp
  ]
  scope: resourceGroup(mainresourceGroupName)
}

module vnetpeerFirstToSecond 'vnetpeering.bicep' = {
   name: '${vnetName}-${vnetSecondName}'
   params: {
    existingLocalVNetName: vnetName
    existingRemoteVNetName: vnetSecondName
   }
   dependsOn: [
    vnet
    vnetSecond
   ]
   scope: resourceGroup(mainresourceGroupName)
}

module vnetpeerSecondToFirst 'vnetpeering.bicep' = {
  name: '${vnetSecondName}-${vnetName}'
  params: {
   existingLocalVNetName: vnetSecondName
   existingRemoteVNetName: vnetName
  }
  dependsOn: [
    vnet
    vnetSecond
   ]
  scope: resourceGroup(mainresourceGroupName)
}
