# Terraform Kubernetes RBAC Module  

Terraform module to create following resources:  
* Kubernetes Role 
* Kubernetes RoleBinding  

The purpose of this module is to assign specific user, or set of users certain permissions within kubernetes cluster. This module ONLY creates Role and RoleBinding for a single namespace. ClusterRole and ClusterRoleBinding are not supported.  

## Compatibility
This module is meant for use with Terraform 0.14 and above. 

## Usage  

```hcl
provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "test" {
  source    = "../"
  name      = "test"
  namespace = "default"
  rules = [
    {
      api_groups     = [""]
      resources      = ["pods"]
      resource_names = ["foo"]
      verbs          = ["get", "list", "watch"]
    },
    {
      api_groups     = ["apps"]
      resources      = ["deployments"]
      resource_names = ["*"]
      verbs          = ["get", "list"]
    }
  ]
  members = [
    {
      kind      = "User"
      name      = "admin"
      api_group = "rbac.authorization.k8s.io"
    }
  ]
}
```