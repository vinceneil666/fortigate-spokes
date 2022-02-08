# output the public ip and user/pass of the fortigate at end of deployment
output "Fortigate-Password" {
  value = module.fgt1.Password
}
output "Fortigate-Username" {
  value = module.fgt1.Username
}
output "Foritgate-Pub-IP" {
  value = module.fgt1.FGTPublicIP
}
