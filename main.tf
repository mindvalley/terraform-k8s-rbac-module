resource "kubernetes_role" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = var.labels
  }

  dynamic "rule" {
    for_each = var.rules
    content {
      api_groups     = rule.value.api_groups
      resources      = rule.value.resources
      resource_names = rule.value.resource_names
      verbs          = rule.value.verbs
    }
  }

}

resource "kubernetes_role_binding" "this" {
  metadata {
    name      = "${var.name}-binding"
    namespace = var.namespace
    labels    = var.labels
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.this.metadata[0].name
  }

  dynamic "subject" {
    for_each = var.members
    content {
      kind      = subject.value.kind
      name      = subject.value.name
      api_group = "rbac.authorization.k8s.io"
    }
  }

}
