# 🚀 Terraform Looping Cheat Sheet

This guide covers how to use loops in Terraform both **with** and **without** `dynamic` blocks. It includes practical examples, when to use which, and why.

---

## ✅ 1. Looping WITHOUT `dynamic` Blocks

You can loop without `dynamic` when you're dealing with **resources**, **flat attributes**, or **tags**.

### 🧪 Example: Looping Resources with `for_each`

```hcl
variable "instances" {
  default = {
    app  = { ami = "ami-123", type = "t2.micro" },
    db   = { ami = "ami-456", type = "t3.micro" }
  }
}

resource "aws_instance" "example" {
  for_each = var.instances

  ami           = each.value.ami
  instance_type = each.value.type
  tags = {
    Name = each.key
  }
}
```

---

### 🧪 Example: Looping Flat Attributes (Tags)

```hcl
variable "tags" {
  default = {
    Environment = "dev"
    Owner       = "admin"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "my-unique-bucket-name"
  tags   = var.tags
}
```

✅ No `dynamic` needed here.

---

## ✅ 2. Looping WITH `dynamic` Blocks (Required for Nested Blocks)

Use `dynamic` when looping over nested blocks like `ingress`, `egress`, `ebs_block_device`, etc.

### 🧪 Example: Dynamic Ingress Rules

```hcl
variable "ingress_rules" {
  default = [
    { from = 80, to = 80, cidr = ["0.0.0.0/0"] },
    { from = 443, to = 443, cidr = ["0.0.0.0/0"] }
  ]
}

resource "aws_security_group" "web" {
  name = "web-sg"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr
    }
  }
}
```

⚠️ You **cannot** write a `for_each` loop directly inside a block like this:

```hcl
# ❌ Invalid
ingress {
  for_each = var.ingress_rules
  ...
}
```

---

## ✅ 3. Summary Table

| Use Case                     | Use `dynamic`? | Notes                                          |
| ---------------------------- | -------------- | ---------------------------------------------- |
| Looping multiple resources   | ❌ No           | Use `for_each` on the resource block           |
| Looping tags or flat values  | ❌ No           | Use plain maps or loops inside `locals`        |
| Looping over nested blocks   | ✅ Yes          | Use `dynamic` block with `for_each`            |
| Conditionally include blocks | ✅ Yes          | Combine with `if` conditions inside `for_each` |

---
Sure! Here's the **normal `.md` format** (Markdown text only, no emojis, no download links):

````md
# Terraform State

## What is State?

State refers to the condition of cloud infrastructure at a specific point in time.  
Example: We expect a Virtual Machine to be running CentOS on AWS with a compute type of t2.micro.

## How does Terraform preserve state?

Terraform stores infrastructure state in a file called `terraform.tfstate`.

- This file is a JSON data structure.
- It maintains a one-to-one mapping from resource instances to remote cloud objects.

## Sample terraform.tfstate file (simplified)

```json
{
  "version": 4,
  "terraform_version": "1.0.4",
  "resources": [
    {
      "type": "aws_instance",
      "name": "example_server",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "attributes": {
            "ami": "ami-0c02b2c1",
            "instance_type": "t2.micro"
          }
        }
      ]
    }
  ]
}
````

## Terraform Workflow

1. You write configuration files:

   * main.tf
   * variables.tf
   * terraform.tfvars

2. Run the command:

   ```bash
   terraform apply
   ```

3. Terraform will:

   * Connect to cloud providers (like AWS, Azure, GCP)
   * Create the infrastructure
   * Save the current state to the `terraform.tfstate` file

This state file helps Terraform understand what resources it manages and keeps track of them during future operations like updates or deletions.

```

Let me know if you want the same format for other Terraform concepts.
```
Here’s a clean, Markdown-style explanation of commonly used **Terraform state commands**, written in your preferred format:

---

# Terraform State Commands

Terraform uses `terraform state` commands to **inspect**, **modify**, and **interact with** the state file (`terraform.tfstate`). These are advanced commands usually used when you need to fix state issues or manage resources manually.

---

## 1. `terraform state list`

**Purpose:**
Lists all resources tracked in the current state file.

**Example:**

```
terraform state list
```

**Output:**
Displays resources like:

```
aws_instance.example
aws_s3_bucket.my_bucket
```

---

## 2. `terraform state show`

**Purpose:**
Shows detailed information about a specific resource from the state file.

**Example:**

```
terraform state show aws_instance.example
```

**Output:**
Displays all attributes like AMI ID, instance type, tags, etc.

---

## 3. `terraform state mv`

**Purpose:**
Moves a resource from one name to another in the state (useful for refactoring).

**Example:**

```
terraform state mv aws_instance.old_name aws_instance.new_name
```

This does **not** affect the real infrastructure—only the state file is updated.

---

## 4. `terraform state rm`

**Purpose:**
Removes a resource from the state file.

**Example:**

```
terraform state rm aws_instance.example
```

**Note:**
The resource will no longer be tracked by Terraform, but it still exists in your cloud provider. Use with caution.

---

## 5. `terraform state pull`

**Purpose:**
Downloads and prints the current state file to stdout (especially useful when using remote state).

**Example:**

```
terraform state pull
```

---

## 6. `terraform state push`

**Purpose:**
Manually uploads a local state file to remote state backend (used rarely).

**Example:**

```
terraform state push path/to/terraform.tfstate
```

---

## 7. `terraform state replace-provider`

**Purpose:**
Replaces the provider source in the state. Used during provider source address changes.

**Example:**

```
terraform state replace-provider old_provider new_provider
```

---

## When to Use State Commands

Use these commands when:

* You manually moved a resource outside Terraform
* You renamed a resource block
* You’re cleaning or restructuring your infrastructure code
* You want to diagnose state issues without running `apply`

---

Let me know if you'd like a `.md`, `.txt`, or `.pdf` version of this, or want examples for specific cloud resources like AWS, GCP, or Azure.
Here is the explanation of the **Terraform `state mv` command** as shown in your screenshot, preserving all the original content and expanding it for better understanding:

---

# Terraform State `mv`

The command:

```
terraform state mv
```

**allows you to:**

* Rename existing resources
* Move a resource into a module
* Move a module into a module

---

## Why use `terraform state mv`?

If you rename or move a resource/module directly in your `.tf` files and run `terraform apply`, Terraform **will destroy the old resource and create a new one**.

This leads to **downtime**, **data loss**, or **unexpected billing**.

To avoid that, use `terraform state mv`. It updates the **state file** to reflect the new name or location **without changing the actual infrastructure**.

---

### Rename Resource Example

```bash
terraform state mv packet_device.worker packet_device.helper
```

**What it does:**
Changes the name of the resource from `worker` to `helper` inside the `packet_device` resource block in the state file.

Result:
Terraform won’t destroy and recreate. It just tracks it under the new name.

---

### Move Resource into Module Example

```bash
terraform state mv packet_device.worker module.worker.packet_device.worker
```

**What it does:**
Moves the `packet_device.worker` resource into a module named `worker`.

Result:
Terraform recognizes that this resource is now under a module.
No deletion or recreation happens.

---

## Summary

Using `terraform state mv` is useful during:

* **Code refactoring** (renaming or moving resources)
* **Adding modular structure**
* **Maintaining resource continuity** without deletion and recreation

This command ensures that changes to naming or structure **don’t result in downtime or resource loss**.

Let me know if you'd like the same type of explanation for `terraform state rm`, `list`, or others.
Here is the explanation of the **Terraform `state mv` command** as shown in your screenshot, preserving all the original content and expanding it for better understanding:

---

# Terraform State `mv`

The command:

```
terraform state mv
```

**allows you to:**

* Rename existing resources
* Move a resource into a module
* Move a module into a module

---

## Why use `terraform state mv`?

If you rename or move a resource/module directly in your `.tf` files and run `terraform apply`, Terraform **will destroy the old resource and create a new one**.

This leads to **downtime**, **data loss**, or **unexpected billing**.

To avoid that, use `terraform state mv`. It updates the **state file** to reflect the new name or location **without changing the actual infrastructure**.

---

### Rename Resource Example

```bash
terraform state mv packet_device.worker packet_device.helper
```

**What it does:**
Changes the name of the resource from `worker` to `helper` inside the `packet_device` resource block in the state file.

Result:
Terraform won’t destroy and recreate. It just tracks it under the new name.

---

### Move Resource into Module Example

```bash
terraform state mv packet_device.worker module.worker.packet_device.worker
```

**What it does:**
Moves the `packet_device.worker` resource into a module named `worker`.

Result:
Terraform recognizes that this resource is now under a module.
No deletion or recreation happens.

---

## Summary

Using `terraform state mv` is useful during:

* **Code refactoring** (renaming or moving resources)
* **Adding modular structure**
* **Maintaining resource continuity** without deletion and recreation

This command ensures that changes to naming or structure **don’t result in downtime or resource loss**.

Let me know if you'd like the same type of explanation for `terraform state rm`, `list`, or others.
Here is the explanation of **Terraform State Backups**, keeping all the content from your screenshot and expanding it clearly:

---

# Terraform State Backups

> **Source line (preserved):**
> All terraform state subcommands that *modify* state will write a backup file.
> Read-only commands will not modify state (e.g. `list`, `show`).

---

## What does this mean?

Whenever you use a Terraform command that **modifies the state file**, Terraform automatically creates a backup of the current state file to protect against accidental loss or corruption.

---

## How does it work?

Terraform will:

* Take the current state stored in `terraform.tfstate`
* Save a backup copy as `terraform.tfstate.backup`

These two files will be present in your working directory:

```
terraform.tfstate
terraform.tfstate.backup
```

---

## Why does Terraform create backups?

To **enforce best practices** for disaster recovery. If your main `terraform.tfstate` file gets corrupted or overwritten, you can manually restore it using the `.backup` file.

---

## Can you disable this behavior?

> **Source line (preserved):**
> Backups cannot be disabled. This is by design to enforce best-practice for recovery.

So no, Terraform **does not allow disabling backup creation**. It's built-in for safety.

---

## How to remove the backup file?

> **Source line (preserved):**
> To get rid of the backup file you need to manually delete the files

You have to delete it manually:

```bash
rm terraform.tfstate.backup
```

Note: Only delete it if you're sure you no longer need recovery options.

---

## Summary

* Terraform writes `.backup` files every time it modifies state
* It ensures you have a fallback if something goes wrong
* You must delete `.backup` manually if you want to remove it
* This mechanism **cannot be turned off**

Let me know if you'd like this in Markdown format for your notes.

