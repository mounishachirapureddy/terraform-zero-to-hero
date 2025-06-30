provider "aws" {
  region = "eu-north-1"
}

provider "vault" {
  address           = "http://56.228.41.226:8200/"
  skip_child_token  = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = "b688f2b6-ba4b-ea62-2f85-cd5a00538c65"
      secret_id = "c1ab4fc0-672a-e693-3550-875e1f2af15a"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "secret"       # this is the path enabled for KV
  name  = "test-secret"  # this is the secret key you created
}

resource "aws_instance" "my_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name   = "vault-secret-test"
    Secret = data.vault_kv_secret_v2.example.data["foo"]
  }
}
