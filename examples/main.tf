provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "test" {
  source    = "../"
  name      = "test"
  namespace = "default"
  rules = [
    {
      api_groups = [""]
      resources  = ["pods"]
      verbs      = ["get", "list", "watch"]
    },
    {
      api_groups = ["apps"]
      resources  = ["deployments"]
      verbs      = ["get", "list"]
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
