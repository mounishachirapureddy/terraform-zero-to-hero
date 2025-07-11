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
      secret_id = "7f747ddd-f1de-6add-3043-c85bef5a15ed"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "secret"       # this is the path enabled for KV
  name  = "test-secret"  # this is the secret key you created
}

resource "aws_instance" "my_instance" {
  ami           = "ami-00c8ac9147e19828e"
  instance_type = "t2.micro"

  tags = {
    Name   = "vault-secret-test"
    Secret = data.vault_kv_secret_v2.example.data["foo"]
  }
}
