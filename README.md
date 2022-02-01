# dns-as-code
Azure DNS as Code using Azure Bicep

https://luke.geek.nz/azure/azure-public-dns-as-code/

The Microsoft Azure ecosystem offers a lot of capabilities that empower individuals and businesses; one of those capabilities that are often overlooked is DNS (Domain Name System).

Azure DNS allows you to host your DNS domain in Azure, so you can manage your DNS records using the same credentials, billing, and support contract as your other Azure services. Zones can be either public or private, where Private DNS Zones (in Managed Preview) are only visible to VMs that are in your virtual network.

You can configure Azure DNS to resolve hostnames in your public domain. For example, if you purchased the contoso.xyz domain name from a domain name registrar, you can configure Azure DNS to host the contoso.xyz domain and resolve www.contoso.xyz to the IP address of your web server or web app.

In this article, we are going to focus on Azure Public DNS.

I had my external DNS under source control using Terraform and the Cloudflare provider a few years ago. I wanted to see if I use source control and continuous integration to do the same thing using Azure DNS and Azure Bicep.

My theory was I could make a change to a file and then commit it and have the Azure DNS records created or modified automatically, allowing changes to DNS to be gated, approved, scheduled and audited, allowing changes and rollback a lot easier – without having to give people access to be able to create DNS records with no auditability, turns out you can!

Using an Azure DevOps pipeline and repository and Azure Bicep, we will deploy an Azure Public DNS zone to a resource group automatically on a successful commit and any records.