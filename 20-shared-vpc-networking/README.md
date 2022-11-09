# 20-shared-vpc-networking
This code is in charge of managing networking resources for shared VPC projects. The [networking](modules/networking)
module is in charge of creating the following resources:
* Shared VPCs
* Subnets with secondary ranges
* Firewall rules
* NAT gateways
* Private service connect
* VPC Service Controls
* DNS Peering

Environments are defined in [envs](envs) folder. By default every environment will have one shared VPC created in a basic
shared vpc project and one VPC created in a restricted shared vpc project. The restricted project will have VPC Service Controls
enabled and appropriate access levels created.