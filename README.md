Fortigate - Spokes , Terraform, Azure

This will create a standalone Fortigate firewall with two nic's (public / private). It will also create 3 vnet's with 3 subnets in each with routing tables attached and
vnet peering between all spokes and hub.

Traffic moving between subnets in the vnet and between vnet's will need to traverse the fortigate firewall. 

Routing needs to be added to the firewall after deployment.


![image](https://user-images.githubusercontent.com/45621419/153557827-651509b3-dd9a-414c-aa1e-9d40a6578e5e.png)
