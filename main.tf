# Random Password Generate
resource "random_password" "password" {
  length  = 16
  special = true
  keepers = {
    datetime = timestamp()
  }
}

output "password" {
  value     = random_password.password.result
  sensitive = true
}

# Random UUID Generate
resource "random_uuid" "guid" {

}

output "guid" {
  value = random_uuid.guid.result
}

# SSH Public/Private Generate
resource "tls_private_key" "tls" {
  algorithm = "RSA"
}

# Save Public/Private key
resource "local_file" "tls_public" {
  filename = "id_rsa.pub"
  content  = tls_private_key.tls.public_key_openssh
}
resource "local_file" "tls_private" {
  filename = "id_rsa.pem"
  content  = tls_private_key.tls.private_key_pem
  provisioner "local-exec" {
    command = "chmod 600 id_rsa.pem"
  }
}
