resource "tls_private_key" "kube_controller_manager" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "kube_controller_manager" {
  key_algorithm   = tls_private_key.kube_controller_manager.algorithm
  private_key_pem = tls_private_key.kube_controller_manager.private_key_pem

  subject {
    common_name         = "system:kube-controller-manager"
    organization        = "system:kube-controller-manager"
    country             = "FR"
    locality            = "Paris"
    organizational_unit = "Kubernetes The Hard Way"
    province            = "IdF"
  }
}

resource "tls_locally_signed_cert" "kube_controller_manager" {
  cert_request_pem   = tls_cert_request.kube_controller_manager.cert_request_pem
  ca_key_algorithm   = tls_private_key.kube_ca.algorithm
  ca_private_key_pem = tls_private_key.kube_ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.kube_ca.cert_pem

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "cert_signing",
    "client_auth",
    "server_auth",
  ]
}

resource "local_file" "kube_controller_manager_key" {
  content  = tls_private_key.kube_controller_manager.private_key_pem
  filename = "./generated/tls/kube-controller-manager-key.pem"
}

resource "local_file" "kube_controller_manager_crt" {
  content  = tls_locally_signed_cert.kube_controller_manager.cert_pem
  filename = "./generated/tls/kube-controller-manager.pem"
}

