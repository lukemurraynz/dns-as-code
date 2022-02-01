///Variables - Edit, these variables can be set in the script or implemented as part of Azure DevOps variables.
//Set the Domain Name Zone:
param PrimaryDNSZone string = ''
//Deploys to the location of your resource group, that is specified during the deployment.
var location = 'Global'
//Variable array for your A records. Add, remove and amend as needed, any new record needs to be included in {}.
var arecords = [
  {
    name: '@'
    ipv4Address: '8.8.8.8'
  }
  {
    name: 'webmail'
    ipv4Address: '8.8.8.8'
  }
]
//Variable array for your CNAME records. Add, remove and amend as needed, any new record needs to be included in {}.
var cnamerecords = [
  {
    name: 'blog'
    value: 'luke.geek.nz'
  }
]

// 

var txtrecords = [
  {
    name: '@'
    value: 'v=spf1 include:spf.protection.outlook.com -all'
  }
    
  ]

///Deploys your infrastructure below.

//Deploys your DNS Zone.

resource DNSZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: toLower(PrimaryDNSZone)
  location: location
  properties: {
    zoneType: 'Public'
  }
}

//Deploys your A records that are listed in the arecord variable table above.

resource DNSARecords 'Microsoft.Network/dnsZones/A@2018-05-01' = [for arecord in arecords: {
  name: toLower(arecord.name)
  parent: DNSZone
  properties: {
    TTL: 3600
    ARecords: [
      {
        ipv4Address: arecord.ipv4Address
      }
      
    ]
  targetResource: {}
  }
}]

//Deploys your CNAME records that are listed in the cnamerecord variable table above.

resource CNAMErecords 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = [for cnamerecord in cnamerecords: {
  name: toLower(cnamerecord.name)
  parent: DNSZone

  properties: {
    'TTL': 3600
    CNAMERecord: {
      
      cname: cnamerecord.value
      
    }
  targetResource: {}
  }
}]

resource TXTrecords 'Microsoft.Network/dnsZones/TXT@2018-05-01' = [for txtrecord in txtrecords: {
name: toLower(txtrecord.name)
parent: DNSZone

properties: {
   'TTL': 3600
   TXTRecords: [
      {
 value: [
        txtrecord.value               
       ]
      }
      
    ]
}
     
 
}]


output cnamerecords string = CNAMErecords[0].properties.CNAMERecord.cname
output arecords string = arecords[0].ipv4Address
