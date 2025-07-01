
## 🔐 HashiCorp Vault - Two Main Modes

### 1. 🧪 **Development Mode (`-dev`)**

* Used for **testing** and **learning** only.
* Start with:

  ```bash
  vault server -dev
  ```
* ✅ **No setup needed**, runs instantly.
* 🛑 **Not secure**:

  * Root token is printed on screen.
  * Data is stored in memory (💾 gone after stop).
* Great for:

  * Practicing commands
  * Testing apps with Vault

---

### 2. 🏭 **Production Mode**/server mode

* Used in **real environments**.
* Needs **proper configuration**:

  * Storage backend (like Consul, file, etc.)
  * TLS certificates for secure HTTPS
  * Access policies and authentication methods
* 🛡️ **Secure and persistent**
* Requires:

  * Initialization
  * Unsealing
* Example:

  ```bash
  vault server -config=/etc/vault/config.hcl
  ```

---

### 📌 Summary Table

| Mode      | Purpose            | Secure | Persistent | Use Case        |
| --------- | ------------------ | ------ | ---------- | --------------- |
| Dev Mode  | Testing & Learning | ❌      | ❌          | Practice, Demos |
| Prod Mode | Real Usage         | ✅      | ✅          | Apps, Workloads |

---

## 🌐 HashiCorp Vault - Default Port

### 🚪 Default Port: `8200`

* Vault **listens on port `8200`** for HTTP/HTTPS requests.
* This is the **main port** for:

  * Vault CLI commands
  * API calls
  * Web UI (if enabled)

---

### 🔧 Example URL

```bash
export VAULT_ADDR="http://127.0.0.1:8200"
```

* `127.0.0.1`: Localhost (your machine)
* `8200`: Default Vault port

---

### 📦 Other Info

| Protocol | Port | Purpose              |
| -------- | ---- | -------------------- |
| HTTP     | 8200 | Vault API/CLI access |
| HTTPS    | 8200 | (If TLS is enabled)  |

---

### 🛠️ Can I change it?

Yes! In `config.hcl`:

```hcl
listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}
```

Change `8200` to any custom port if needed.

---


## 💾 HashiCorp Vault - Storage

### 📦 What is Storage?

Vault needs a **place to save data**, like:

* Secrets
* Tokens
* Configurations

This place is called the **storage backend**.

---

### 🔧 Common Storage Options

| Storage Type | Description                            | Use Case              |
| ------------ | -------------------------------------- | --------------------- |
| `file`       | Saves data to local disk (files)       | Easy for development  |
| `raft`       | Built-in Vault storage (HA support)    | Best for production   |
| `consul`     | Uses Consul service for storage        | Good for large setups |
| `in-memory`  | Keeps everything in RAM (lost on stop) | Temporary, dev only   |

---

### 🛠️ Example `config.hcl`

```hcl
storage "file" {
  path = "/opt/vault/data"
}
```

Or for Raft:

```hcl
storage "raft" {
  path    = "/opt/vault/data"
  node_id = "vault-node-1"
}
```

---

### 📌 Summary

* Vault needs **storage** to work.
* Choose based on your **environment**:

  * `file` or `in-memory`: good for testing.
  * `raft` or `consul`: best for production.

---


## 🔐 Vault - Unseal Key & Root Token

### 🔑 What is "Unseal Key"?

* Vault **encrypts all data** by default.
* To access data, Vault must be **unsealed** after start.
* When Vault is **initialized**, it creates:

  * **Multiple unseal keys**
  * **A threshold number** needed to unseal (e.g., 3 of 5)

---

### 💡 Example:

You may get **5 keys** like:

```
Unseal Key 1: xxxxxxx
Unseal Key 2: yyyyyyy
...
```
Vault may require **1 key to unseal** (configurable).(**in dev mode**)
And Vault may require **3 keys to unseal** (configurable).(**in production mode**)

To unseal Vault:

```bash
vault operator unseal
```

You enter one key at a time until Vault is unsealed.

---

### 🧑‍💼 What is "Root Token"?

* After initialization, Vault gives you **1 root token**.
* It’s like the **admin password** for Vault.
* You use it to:

  * Set up users and policies
  * Enable secret engines
  * Do anything in Vault

```bash
export VAULT_TOKEN="s.abc123xyz"
```

---

### 📌 Summary Table

| Term       | Purpose                    | When It's Used        |
| ---------- | -------------------------- | --------------------- |
| Unseal Key | Unlocks Vault after start  | After every restart   |
| Root Token | Full admin access to Vault | After init, for setup |

---

### 🚨 Keep Them Safe!

* Unseal keys should be shared **securely** with trusted people (Shamir’s secret sharing).
* Root token should be stored **securely** or revoked after setup.

---

Sure! Here's a **combined and very easy explanation** of **Unseal Keys**, **Root Token**, and how to **use them step-by-step**, written in clean **Markdown (MD)** format:

---

## 🔐 HashiCorp Vault - Unseal Key, Root Token, and CLI Setup

---

### 🧠 What Are They?

| Term           | Description                                                                    |
| -------------- | ------------------------------------------------------------------------------ |
| **Unseal Key** | Used to unlock Vault after it starts. Vault is sealed by default for security. |
| **Root Token** | Admin token with full access to Vault. Used after initialization.              |

---

### ⚙️ When Are They Created?

When you run:

```bash
vault operator init
```

Vault gives you:

* **Unseal Keys** (e.g., 5 keys, need 3 to unseal)
* **Root Token** (used to log in as admin)

---

### 📦 Sample Output of `vault operator init`:

```
Unseal Key 1: abcd-1111
Unseal Key 2: abcd-2222
Unseal Key 3: abcd-3333
Unseal Key 4: abcd-4444
Unseal Key 5: abcd-5555

Initial Root Token: s.abc123xyz
```

> ⚠️ Save these safely — losing them means losing access!

---

## 🚀 Step-by-Step CLI Setup

### 🛠️ Step 1: Start Vault Server

#### ✅ For Learning Only (Dev Mode):

```bash
vault server -dev
```

* Auto unsealed
* Auto root token
* Not secure

#### 🏭 For Real Use (Production Mode):

1. Create `config.hcl`:

```hcl
listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1
}
storage "file" {
  path = "/opt/vault/data"
}
```

2. Start Vault:

```bash
vault server -config=config.hcl
```

3. Set address:

```bash
export VAULT_ADDR="http://127.0.0.1:8200"
```

---

### 🔐 Step 2: Initialize Vault

```bash
vault operator init
```

* Gives **5 unseal keys**
* Requires **3 keys** to unseal (by default)
* Gives **root token**

---

### 🔓 Step 3: Unseal Vault (3 keys needed)

```bash
vault operator unseal
# Paste Unseal Key 1

vault operator unseal
# Paste Unseal Key 2

vault operator unseal
# Paste Unseal Key 3
```

> Vault is now **unsealed** and running!

---

### 🔑 Step 4: Login with Root Token

```bash
vault login s.abc123xyz
```

> You are now logged in as **Vault admin**.

---

## 📌 Summary Table

| Item       | Purpose                          | Needed When          |
| ---------- | -------------------------------- | -------------------- |
| Unseal Key | Unlocks Vault after restart      | After every restart  |
| Root Token | Full admin access to setup Vault | After initialization |

---

Yes, you're **absolutely right!** ✅

---

## 🧪 Dev Mode: Only **One Unseal Key**

When you run Vault in **development mode** using:

```bash
vault server -dev
```

### 🔐 What Happens?

* Vault **auto-initializes** and **auto-unseals**
* It gives:

  * **1 Unseal Key**
  * **1 Root Token**
* You **don’t need to unseal manually** – it’s already unsealed.
* Data is stored **in memory only** (🧠), and will be lost after restart.

---

### 🔎 Sample Output:

```
Unseal Key: xxxxxx-xxxx-xxxx-xxxx-xxxxxxxx
Root Token: s.xxxxxxxx
```

> ⚠️ This unseal key is not split into multiple parts like in production.

---

## 🔒 Production Mode: Multiple Unseal Keys

When you run:

```bash
vault operator init
```

You get:

* **5 Unseal Keys**
* Need any **3 to unseal Vault**
* This uses **Shamir’s Secret Sharing** (for high security)

---

## 📌 Summary Table

| Mode      | Unseal Keys   | Need Manual Unseal?  | Secure? |
| --------- | ------------- | -------------------- | ------- |
| Dev Mode  | 1 key (auto)  | ❌ No                 | ❌ No    |
| Prod Mode | 5 keys (e.g.) | ✅ Yes (e.g., 3 of 5) | ✅ Yes   |

---

Here’s a **very simple explanation** of `export VAULT_ADDR` and `export VAULT_TOKEN` in **Markdown (MD)** format with real examples:

---

## 🌐 `export VAULT_ADDR` and `export VAULT_TOKEN`

These are **environment variables** used by Vault CLI to know:

1. **Where** Vault is running (`VAULT_ADDR`)
2. **How** to authenticate (`VAULT_TOKEN`)

---

### 📍 1. `VAULT_ADDR` – Vault Address

```bash
export VAULT_ADDR="http://127.0.0.1:8200"
```

* Tells Vault CLI the **URL** to connect to.
* Default port is **8200**
* Use `http://localhost:8200` or `https://vault.mydomain.com` depending on your setup.

✅ Required before you run Vault commands like `vault status`, `vault login`, etc.

---

### 🔑 2. `VAULT_TOKEN` – Root/Admin Token

```bash
export VAULT_TOKEN="s.abc123xyz"
```

* Stores your **authentication token** (like password).
* Vault CLI uses it automatically, so you don’t have to type it every time.

✅ Required for commands like `vault secrets enable`, `vault kv put`, etc.

---

### 🧪 Example: After Starting Vault in Dev Mode

```bash
vault server -dev
```

Output:

```
Unseal Key: xxxxxx-xxxx
Root Token: s.abcd1234
```

Then in another terminal:

```bash
export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN="s.abcd1234"
```

Now you can run:

```bash
vault status
vault kv put secret/hello value=world
vault kv get secret/hello
```

---
### ✅ `vault status` — Very Easy Explanation

---

## 📘 What Does It Do?

The `vault status` command shows the **current state** of your Vault server.

It tells you if:

* Vault is **initialized**
* Vault is **sealed or unsealed**
* How many **unseal keys** are needed
* What type of **storage backend** is used

---

## 🧪 Example Output (Dev Mode or Prod Mode)

```bash
$ vault status
```

```
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    5
Threshold       3
Version         1.15.2
Cluster Name    vault-cluster-1234
Cluster ID      abcd-efgh-5678
HA Enabled      false
```

---

## 🔍 Field Breakdown

| Field            | Meaning                                |
| ---------------- | -------------------------------------- |
| **Seal Type**    | Type of encryption (usually `shamir`)  |
| **Initialized**  | Has `vault operator init` been run?    |
| **Sealed**       | Is the Vault locked? (`true` = locked) |
| **Total Shares** | Total unseal keys created              |
| **Threshold**    | How many keys are needed to unseal     |
| **Version**      | Vault software version                 |
| **HA Enabled**   | Is High Availability mode enabled?     |

---

## ✅ When to Use It?

* After starting Vault, to check if it’s ready
* After unsealing, to confirm it’s **unsealed**
* To check Vault **health** status anytime

---



