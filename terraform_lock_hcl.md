
### ❓ What is `terraform.lock.hcl`?

It is a file **automatically created by Terraform** when you run:

```
terraform init
```

---

### ✅ Why is it created?

To **lock the provider versions** (like AWS, GCP, etc.) so that:

* You and your team all use the **same versions**.
* Terraform doesn’t suddenly **use a new version** that might break your setup.

---

### 📦 Example

Let’s say your code needs the AWS provider.

If you don’t lock it:

* One person might use version 5.0
* Another might use version 4.0
* That can cause **errors or different behavior**

With `terraform.lock.hcl`:

* Everyone uses the **same version** (example: 5.29.0)
* No surprises!

---

### 📌 Simple Summary

| Thing                   | What it means                         |
| ----------------------- | ------------------------------------- |
| 🔒 `terraform.lock.hcl` | Remembers the exact provider versions |
| 🛡️ Purpose             | Keeps your setup safe and consistent  |
| ✅ You should commit it? | Yes, always commit this file to Git   |
| 🔄 Updates when?        | When you change or upgrade providers  |

