
# 🛰️ Terraform Provisioner: Remote-Exec

## 📌 What is `remote-exec`?

`remote-exec` is a **Terraform provisioner** that allows you to **execute commands on a target resource *after* it has been provisioned**.

---

## 📊 Visual Overview

```
Local Machine                   remote-exec                  Provisioned VM
executing Terraform  -------------------------->  executing provided commands/script
```

* **Local Machine**: Runs your Terraform code.
* **Provisioned VM**: The infrastructure resource created by Terraform (e.g., EC2, Azure VM).
* **remote-exec**: Executes post-provisioning shell commands/scripts **on the remote resource**.

---

## ✅ Use Case

* Ideal for running **simple provisioning scripts** like installing packages, updating OS, setting environment variables, etc.
* For example:

  ```hcl
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y"
    ]
  }
  ```

---

## ⚠️ Recommendation from Experts

> **For more complex tasks**, it's recommended to use **Cloud-Init**
> and strongly recommended in all cases to **bake Golden Images** via tools like:

* 🧁 **Packer**
* 📷 **EC2 Image Builder**

These tools help you **pre-build VMs/images** with everything already set up, which is:

* More reliable ✅
* Repeatable 🔁
* Scalable across environments 📈

---

## 📝 Summary

| Feature    | Description                                             |
| ---------- | ------------------------------------------------------- |
| Purpose    | Run commands on a resource **after** it's created       |
| Works With | VMs (EC2, Azure VM, GCP Compute Engine)                 |
| Good For   | Simple setups (installing software, basic configs)      |
| Avoid For  | Complex provisioning — use Cloud-Init or Packer instead |

---
Here is a `README.md` style explanation of the **three different modes of `remote-exec`** provisioner in **Terraform**, explained clearly and concisely:

---

# 🧰 Terraform `remote-exec` Provisioner – Modes Explained

The `remote-exec` provisioner in Terraform allows you to execute **scripts or commands** on a remote resource (like an EC2 instance) **after it's created**.

Terraform supports **3 modes** of remote-exec connection:

---

## 🔧 1. `inline` Mode

* **Description**: Run commands directly written inside the Terraform configuration.
* **Use Case**: Useful for quick one-liner setup or basic configuration steps.

```hcl
provisioner "remote-exec" {
  inline = [
    "sudo apt-get update",
    "sudo apt-get install -y nginx"
  ]
}
```

📝 *Each command is executed sequentially as if typed in a shell.*

---

## 📜 2. `script` Mode

* **Description**: Runs a **local shell script file** on the remote machine.
* **Use Case**: Ideal when your setup logic is too complex for inline commands.

```hcl
provisioner "remote-exec" {
  script = "setup.sh"
}
```

📝 *The `setup.sh` script must be present on your local machine and is copied to the remote instance before execution.*

---

## 📁 3. `scripts` Mode (with `scripts = []`)

* **Description**: (Unofficial/Custom) Refers to chaining multiple script files.
* **Use Case**: Not directly supported by Terraform core, but users implement it using multiple `remote-exec` blocks or `null_resource`.

Example using multiple provisioners:

```hcl
provisioner "remote-exec" {
  script = "setup-part1.sh"
}

provisioner "remote-exec" {
  script = "setup-part2.sh"
}
```

📝 *Used for breaking down scripts into manageable chunks or logical steps.*

---

## 🔐 Connection Block Example

Each mode requires a `connection` block to define **SSH access details**:

```hcl
connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file("~/.ssh/id_rsa")
  host        = self.public_ip
}
```

---

## ✅ Summary

| Mode      | Key Field         | Used For                          | Example Use                 |
| --------- | ----------------- | --------------------------------- | --------------------------- |
| inline    | `inline`          | Quick shell commands              | `apt update`, `yum install` |
| script    | `script`          | Run full shell scripts            | `setup.sh`, `init_db.sh`    |
| scripts\* | multiple `script` | Modular, multiple script chaining | `part1.sh`, `part2.sh`      |

> ⚠️ *scripts\[] is not an official mode, but a user pattern via multiple `remote-exec`.*

---

Here is a `README.md` style explanation of **Terraform `file` provisioner** and its modes—just like the `remote-exec` explanation above:

---

# 📦 Terraform `file` Provisioner – Modes Explained

The `file` provisioner is used to **upload files or directories** from your **local machine to a remote resource** (like a VM or EC2 instance) **after it's created**.

Terraform supports **3 common usage modes** for the `file` provisioner:

---

## 📁 1. **Single File Upload**

* **Description**: Copies a single file from your local system to a remote path.
* **Use Case**: Upload configuration files, credentials, scripts, etc.

```hcl
provisioner "file" {
  source      = "app.conf"
  destination = "/etc/app.conf"
}
```

📝 *Copies `app.conf` from local to the remote system.*

---

## 📂 2. **Directory Upload**

* **Description**: Copies a **whole folder recursively**.
* **Use Case**: When you need to transfer multiple files, app code, or complex configurations.

```hcl
provisioner "file" {
  source      = "app_folder/"
  destination = "/opt/app/"
}
```

📝 *The trailing `/` ensures directory content is copied, not the folder itself.*

---

## 🛠️ 3. **File Templating Before Upload** (using `templatefile()` + `file`)

* **Description**: Render a template file (e.g., `*.tpl`) using variables before uploading it.
* **Use Case**: When the uploaded file needs to be dynamically customized (e.g., hostname, environment).

```hcl
data "template_file" "config" {
  template = file("${path.module}/config.tpl")
  vars = {
    env  = "production"
    port = 8080
  }
}

resource "null_resource" "upload_config" {
  provisioner "file" {
    content     = data.template_file.config.rendered
    destination = "/etc/myapp/config.cfg"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }
}
```

📝 *This approach uses dynamic content instead of static files.*

---

## 🔐 Connection Block Example

The `file` provisioner also requires a connection block (like `remote-exec`):

```hcl
connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file("~/.ssh/id_rsa")
  host        = self.public_ip
}
```

---

## ✅ Summary

| Mode                  | Key Fields               | Used For                            | Notes                                       |
| --------------------- | ------------------------ | ----------------------------------- | ------------------------------------------- |
| Single File Upload    | `source`, `destination`  | Copy one file                       | Simple and fast                             |
| Directory Upload      | `source` (folder path)   | Copy multiple files or whole folder | Use trailing `/` for folder content         |
| Templated File Upload | `content`, `destination` | Upload rendered dynamic config      | Needs `templatefile()` + `file provisioner` |

---

Here is a `README.md` style explanation of the **types of `connection` blocks** in Terraform:

---

# 🔌 Terraform `connection` Block – Types Explained

The `connection` block in Terraform defines **how Terraform connects** to the remote resource (e.g., EC2, VM) to run **provisioners** like `remote-exec` or `file`.

There are **2 main connection types**:

---

## 1️⃣ `ssh` – For Linux/Unix Machines

* **Used For**: Connecting to Linux-based virtual machines (EC2, GCP VM, Azure VM, etc.)
* **Protocol**: Secure Shell (SSH)
* **Authentication**: Private key or password

```hcl
connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file("~/.ssh/id_rsa")
  host        = self.public_ip
}
```

🔑 **Alternate option (password-based)**:

```hcl
connection {
  type     = "ssh"
  user     = "ubuntu"
  password = "yourpassword"
  host     = self.public_ip
}
```

---

## 2️⃣ `winrm` – For Windows Machines

* **Used For**: Connecting to **Windows** virtual machines
* **Protocol**: Windows Remote Management (WinRM)
* **Authentication**: Username and password

```hcl
connection {
  type     = "winrm"
  user     = "Administrator"
  password = "YourPassword123!"
  host     = self.public_ip
  port     = 5986
  https    = true
  insecure = true
}
```

🛡️ *Port 5986 is default for HTTPS WinRM. `insecure = true` is often required for self-signed certs.*

---

## ✅ Summary Table

| Type    | Used For       | Protocol | Auth Method             | Notes                                |
| ------- | -------------- | -------- | ----------------------- | ------------------------------------ |
| `ssh`   | Linux/Unix VMs | SSH      | Private key or password | Most commonly used                   |
| `winrm` | Windows VMs    | WinRM    | Username + Password     | Requires port 5986 and WinRM enabled |

---

Here is a `README.md` style explanation of **Terraform `null_resource`**, written in the same clear format as previous ones:

---

# 🧱 Terraform `null_resource` – Explained

The `null_resource` in Terraform is a **resource with no infrastructure** attached to it. It is mainly used to run **provisioners**, **local-exec**, or **remote-exec** scripts for custom tasks.

> 📌 It doesn't create any cloud resource (like EC2, S3, etc.) — it just runs actions during apply.

---

## 🚀 1. Basic Usage

```hcl
resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo Hello, Terraform!"
  }
}
```

📝 *This just prints a message during `terraform apply`.*

---

## ⚙️ 2. With Triggers (to force re-execution)

* **Use Case**: When you want the `null_resource` to run again if input values change.

```hcl
resource "null_resource" "restart_service" {
  triggers = {
    script_version = "v1.2.3"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl restart myapp"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.app_server.public_ip
  }
}
```

📝 *Changing `script_version` will re-run the `null_resource`.*

---

## 🧰 3. Common Use Cases

| Use Case                                | Example                                           |
| --------------------------------------- | ------------------------------------------------- |
| Run provisioners without creating infra | Just want to copy a file or run a command         |
| Trigger actions based on file/version   | Use `triggers` to force re-run when input changes |
| Run local scripts or shell commands     | `local-exec` for local tasks during apply         |
| Upload files or configure remote        | Use with `remote-exec` or `file` provisioners     |

---

## 🧪 Example: Upload & Execute Script Remotely

```hcl
resource "null_resource" "deploy_script" {
  provisioner "file" {
    source      = "deploy.sh"
    destination = "/tmp/deploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/deploy.sh",
      "/tmp/deploy.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.my_instance.public_ip
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
```

📝 *`timestamp()` ensures this always runs on every apply.*

---

## ✅ Summary

| Feature           | Description                                  |
| ----------------- | -------------------------------------------- |
| No real resource  | Doesn't create infra like EC2, S3, etc.      |
| Runs provisioners | Supports `file`, `local-exec`, `remote-exec` |
| Use triggers      | Force re-run based on variable/file changes  |
| Good for scripts  | Custom tasks before/after resource creation  |

---

Ah, thank you for the clarification! You’re asking:

> 📌 **When should I use a `null_resource` with provisioners, and when should I use a provisioner directly inside a resource (like EC2)?**

Here is the full explanation in **`README.md` style**, comparing **`null_resource` vs. normal provisioner inside resource block**, with clear use cases and differences:

---

# 🔍 Terraform Provisioners: `null_resource` vs. Inline in Resource

Terraform provisioners like `remote-exec`, `local-exec`, and `file` can be used in **two ways**:

1. ✅ Directly **inside a resource** (e.g., `aws_instance`)
2. ✅ Inside a **`null_resource`**

---

## ⚙️ Option 1: **Provisioner Inside a Resource Block**

### ✅ When to Use:

* Simple provisioning needed right **after** resource creation
* Provisioning logic is tightly coupled to a single resource
* You don't need advanced control over when provisioners re-run

### 📦 Example:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-0abc123456"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }
}
```

---

## 🧱 Option 2: **Provisioner with `null_resource`**

### ✅ When to Use:

* You want to **separate provisioning logic** from the resource
* You need to **control re-execution** using `triggers`
* You want to **reuse** the provisioner logic for multiple resources
* You want to run provisioners **on existing infrastructure**
* You want to **combine provisioners** (e.g., `file` + `remote-exec`) modularly

### 📦 Example:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-0abc123456"
  instance_type = "t2.micro"
}

resource "null_resource" "setup" {
  provisioner "remote-exec" {
    inline = [
      "echo Hello from remote VM"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.web.public_ip
  }

  triggers = {
    script_version = "v1.0"
  }

  depends_on = [aws_instance.web]
}
```

---

## 🆚 Comparison Table

| Feature                         | Inline in Resource Block  | `null_resource` with Provisioner         |
| ------------------------------- | ------------------------- | ---------------------------------------- |
| 🔧 Simplicity                   | ✅ Simpler for small tasks | ❌ Slightly more complex                  |
| 🔄 Trigger-based re-run control | ❌ Not supported           | ✅ Yes, using `triggers`                  |
| 🧱 Separation of concerns       | ❌ Logic inside resource   | ✅ Clear separation of resource and logic |
| 🔁 Reusability of logic         | ❌ Resource-specific       | ✅ Easily reusable with variables         |
| ♻️ Provisioning existing infra  | ❌ Cannot be used          | ✅ Can use IP or reference                |
| ⚙️ Modular design               | ❌ Less modular            | ✅ Fully modular and testable             |

---

## 📝 Summary: When to Use Which?

| Use Case                                   | Use This                        |
| ------------------------------------------ | ------------------------------- |
| Simple, one-time setup after creating a VM | Inline Provisioner              |
| You need re-run when version/file changes  | `null_resource` with `triggers` |
| Use with existing infrastructure           | `null_resource`                 |
| Modular or reusable provisioning scripts   | `null_resource`                 |
| Complex logic like multiple provisioners   | `null_resource`                 |

---

