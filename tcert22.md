This slide explains the **Terraform Cloud Private Registry**, which lets you **publish private modules** for use **within your organization**.

---

## 🔐 Terraform Cloud – Private Registry

### 📌 What it is:

Terraform Cloud allows organizations to **publish and share Terraform modules privately** using its **Private Module Registry**.

---

### ✅ **Key Features of the Private Registry:**

* **Module Versioning**
  → Track and use specific versions of a module

* **Searchable & Filterable List**
  → Quickly find the module you need based on filters or keywords

* **Configuration Designer**
  → Helps design the module input/output visually or with prompts

---

### 👥 Access Control:

* **All users in your org** can view the private modules
* No external users can access them

---

### 🔐 Authentication:

To use modules from the private registry via CLI:

* You need an **API token** to authenticate

  * Could be a **User Token** (default when using `terraform login`)
  * Or a **Team Token** (manual setup in the CLI config file)

> ⚠️ Team and User tokens have different permission scopes
> Use the correct one based on your use case (read-only vs publish)

---

### 🧠 Simple Summary:

> The **Private Registry** is like your company’s own Terraform module marketplace.
> It helps manage reusable infrastructure components **securely and efficiently** inside your org.

---

Let me know if you want to try a hands-on example of publishing a module or configuring authentication!
Here is the updated section on **Cost Estimation** with your requested point added:

---

### 💰 **Cost Estimation in Terraform Cloud**

Cost estimation in Terraform Cloud helps you **predict infrastructure costs** *before you apply changes*, so you can make informed decisions and avoid surprises.

---

### ✅ **Key Points:**

| Feature                       | Details                                                                                         |
| ----------------------------- | ----------------------------------------------------------------------------------------------- |
| 📌 **When does it run?**      | Automatically runs during the **Plan** phase                                                    |
| 📦 **What does it estimate?** | Monthly cost of **supported resources only** (e.g., AWS EC2, RDS, S3; Azure VMs; GCP instances) |
| 🛑 **Before Apply?**          | Yes – lets you see how much resources will cost **before** provisioning                         |
| 🔒 **Tier availability**      | **Only available** on **Terraform Cloud Team & Governance tier** or higher                      |
| 🧠 **Based on**               | Pricing data from cloud providers and resource specifications                                   |
| ⚠️ **Important**              | Only **specific resources** are allowed for estimation (not every resource type is supported)   |

---

Let me know if you’d like this added to your document or if you want a list of supported resources!
This screenshot explains the **Terraform Cloud – Workflow Options**, which control how Terraform behaves inside a workspace.

### 🔁 **Terraform Cloud – Workflow Options Explained**

---

#### ✅ 1. **Terraform Version Selection**

* **You can select any version** of Terraform from a dropdown.
* This allows you to **standardize** and **test** specific versions for your infrastructure.
* Useful when:

  * Avoiding breaking changes from newer versions
  * Teams need consistency in environments

---

#### 🌐 2. **Share State Globally**

* **Option:** `Share state globally`
* Allows one workspace to **access the state of other workspaces** in the same organization.
* Useful for:

  * **Cross-workspace dependencies**
  * Workspaces needing access to output of another workspace
  * Ex: VPC defined in one workspace, used in another

---

#### ⚙️ 3. **Auto vs Manual Apply**

* **Auto apply:**

  * Changes are applied **automatically after planning** (ideal for automation).
* **Manual apply:**

  * Requires **user approval** to apply changes after plan.
  * Adds control for **critical environments** like production.

---

Let me know if you'd like this added to your Terraform notes!
This screenshot explains **how to migrate the default local state** in Terraform to **Terraform Cloud** using a **remote backend**.

---

## 🔄 Migrating Default Local State to Terraform Cloud

When you're using Terraform locally (with the default backend), the state file is stored on your machine. To migrate this to **Terraform Cloud** (which stores state remotely):

---

### ✅ Steps:

1. **Create a Workspace** in Terraform Cloud.

   * You’ll later map your configuration to this workspace.

2. **Update your `backend` configuration**:
   Replace:

   ```hcl
   terraform {
   }
   ```

   With:

   ```hcl
   terraform {
     backend "remote" {
       hostname     = "app.terraform.io"
       organization = "my-org"

       workspaces {
         name = "my-workspace"
       }
     }
   }
   ```

3. **Run `terraform init`**

   * Terraform will detect a **backend migration** from `local` to `remote`.

4. **Accept state migration**:

   * Terraform will ask:

     ```
     Do you want to copy existing state to the new backend?
     ```

     * Type **`yes`** to migrate existing state.
     * Type **`no`** to start fresh (⚠ not recommended unless you know what you're doing).

---

### 📌 Result:

* State is now securely stored in **Terraform Cloud**.
* Enables collaboration, history, state locking, and more.

---

Let me know if you'd like this added to your notes or explained in simpler steps!
Here’s the summarized content from the image:

---

### **Terraform Cloud – VCS Integration**

Terraform Cloud can integrate with the following Version Control Systems (VCS):

* GitHub
* GitHub (OAuth)
* GitHub Enterprise
* GitLab
* GitLab EE and CE
* Bitbucket Cloud
* Bitbucket Server and Data Center
* Azure DevOps Service
* Azure DevOps Server

---

#### **Create a New Workspace Steps:**

1. **Connect to VCS** – Select your VCS provider (e.g., GitHub, GitLab).
2. **Choose a Repository** – Pick the repository containing Terraform configuration.
3. **Configure Settings** – Customize workspace settings.

---

This enables automatic Terraform runs when changes are made to the connected repository.
Certainly! Here's a **detailed explanation** of **Terraform Enterprise**, what it is, when to use it, and how its components work together in **real-time enterprise scenarios**:

---

## 🔷 What is Terraform Enterprise?

**Terraform Enterprise (TFE)** is the **self-hosted** and **commercial** version of Terraform Cloud, designed for **large organizations** that need advanced security, scalability, and control.

Instead of using HashiCorp's managed Terraform Cloud, **you install Terraform Enterprise on your own infrastructure**—like on AWS, Azure, GCP, or your private datacenter (e.g., using VMware, OpenStack).

---

## ✅ Why Use Terraform Enterprise? (Real-Time Use Cases)

| Use Case                    | Why TFE Helps                                                                                 |
| --------------------------- | --------------------------------------------------------------------------------------------- |
| 🔐 Security and Compliance  | You can enforce custom security policies, host on your own data center or VPC.                |
| 🧾 Audit and Logging        | Built-in **audit logging** to track who made what changes, required for SOC 2, ISO27001, etc. |
| 🧑‍💼 Identity Integration  | Integrate with **SAML/SSO** providers like Okta, Azure AD for user access control.            |
| 🧰 Team and Role Management | Define **RBAC (Role-Based Access Control)** with fine-grained permissions.                    |
| 🖥️ Full Data Control       | Keep **all state files, secrets, plans** within your own network.                             |
| 📊 Performance at Scale     | No hard usage limits; scalable for thousands of resources and teams.                          |

---

## 🔧 Terraform Enterprise Architecture (Explained from Diagram)

Here's a breakdown of each component you saw in the image:

### 1. **Linux Machine**

* Your base server where TFE will run.
* Can be a VM or physical machine.

### 2. **Terraform Platform Installed**

* The TFE application is deployed on your Linux server.
* It serves a UI, CLI API, VCS connections, etc.

### 3. **PostgreSQL Database**

* Used for storing metadata: workspace info, variables, logs, user settings.
* Must be external or managed (like AWS RDS).

### 4. **Cloud Storage / Cloud Disk**

* Stores **Terraform state files**, plans, and logs.
* Can be S3, GCS, Azure Blob, or NFS disk.

### 5. **TLS Certificate**

* Used to secure HTTPS communication.
* Required for encrypted connections between UI, agents, and clients.

### 6. **Terraform License**

* A paid license from HashiCorp to activate enterprise features.

---

## 🆚 Terraform Enterprise vs Terraform Cloud

| Feature                      | Terraform Cloud (Free/Team) | Terraform Enterprise                  |
| ---------------------------- | --------------------------- | ------------------------------------- |
| Hosting                      | Hosted by HashiCorp         | Hosted by **you (self-hosted)**       |
| Control                      | Limited                     | Full control over data and setup      |
| SAML, LDAP, SSO              | Only on Business plan       | Built-in                              |
| Custom Logging, Backups      | Not possible                | You control logs, monitoring, backups |
| Internet access (air-gapped) | Required                    | Can run **air-gapped**, offline       |

---

## 🏢 Real-Life Example

Let’s say you're a bank or government agency. You **cannot store infrastructure plans and state files on the public cloud** due to data regulations. So you:

* Install **Terraform Enterprise on a private datacenter**.
* Store all Terraform files on your **internal GitLab**.
* Use **internal SAML login** for user authentication.
* Deploy infrastructure (e.g., VMs, DBs) via **TFE agents** that can reach internal systems like VMware vSphere.
* **Log all changes** for audit review.

---

Would you like a visual architecture diagram or how to install steps next?
Here’s a **detailed explanation** of **Air Gapped Environments** in the context of **Terraform Enterprise** based on your image:

---

### 🌐 What Is an Air Gapped Environment?

An **Air Gapped Environment** is a **physically isolated network** or computer system that has **no internet access** — not even for updates, patches, or external API calls.
This setup is done to **maximize security** and prevent any chance of data leaking out or malicious code getting in.

> 🔒 **No Internet. No Outside Connectivity.**
>
> This is sometimes referred to as a **disconnected**, **dark site**, or **secure enclave** environment.

---

### 🏢 Where Are Air Gapped Environments Used?

They're most commonly used in:

* 🛡️ **Public Sector**: Government, defense, military
* 🏦 **Large Enterprises**: Banks, energy companies, or financial institutions
* 🏭 **Critical Infrastructure**: Power plants, water utilities, etc.

These environments are used when:

* Security risks are **extremely high**
* Regulations require **strict data control** (e.g., classified systems)
* External connectivity (even for updates) is considered a threat

---

### 🤝 How Terraform Enterprise Helps

**Terraform Enterprise** supports installation in **air gapped environments** through a **special "Air Gap Bundle"**:

| Feature                | Description                                                                                                                   |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| 📦 **Air Gap Bundle**  | An archive file (.tar.gz) that contains the full Terraform Enterprise platform including updates, dependencies, and binaries. |
| ⚙️ **Offline Install** | You upload this bundle manually to the target machine, and Terraform Enterprise installs/updates without needing internet.    |
| 🔁 **No Auto-Updates** | Everything is managed **manually**, including Terraform versions, providers, and modules.                                     |

---

### 🧱 How This Works in Practice

1. **On a connected machine:**

   * Download the latest Terraform Enterprise air gap bundle from [HashiCorp releases](https://releases.hashicorp.com).
   * Include required providers, binaries, license files, and configurations.

2. **Transfer to Air Gapped Machine:**

   * Copy the bundle using a secure, removable device (e.g., encrypted USB).
   * No public internet needed.

3. **Install/Upgrade TFE Offline:**

   * Extract and install the bundle on your **isolated Linux machine**.
   * Set up Postgres, TLS, cloud disk, etc., locally.

---

### 🔄 Diagram Recap from Image

* ❌ **No internet** (red icon)
* 🏢 Used in **Public Sector** and **Large Enterprise**
* ✅ Terraform Enterprise **supports** this setup with a special **"Airgap" install mode**

---

### 🚨 Important Notes

* Terraform Enterprise in air gap mode **cannot download Terraform providers** or modules on the fly.
* You’ll need to **manually host providers** (like `aws`, `azurerm`) and modules internally.
* Often combined with **internal private registries** or **custom Docker images**.

---

Would you like a **visual workflow** showing how the Air Gapped setup works step-by-step?
Here's a **detailed explanation** of the image content on **Terraform Enterprise Requirements**:

---

## 📋 Terraform Enterprise Requirements (Breakdown)

Terraform Enterprise (TFE) has specific **infrastructure**, **software**, and **credential** requirements for proper setup and operation.

---

### 🟡 **1. Operational Mode**

This refers to **how Terraform Enterprise stores its state data and metadata**. It offers multiple options:

#### a. **External Services** (Recommended for production):

* **PostgreSQL** – used as the TFE application database.
* **Object Storage** – to store Terraform state files:

  * AWS S3 Bucket
  * GCP Cloud Storage Bucket
  * Azure Blob Storage
  * Minio (S3-compatible local object storage)

#### b. **Mounted Disk**:

* Stores data on a **mounted disk** (e.g., EBS, iSCSI) external to the host.
* More control over storage, but requires careful configuration.

#### c. **Demo Mode** (⚠️ Not for Production):

* Stores **all data locally** inside the TFE container.
* Used for **testing**, **training**, or **POCs (Proof of Concepts)**.
* Data can be backed up using snapshots, but not production-ready.

---

### 🔐 **2. Credentials**

You need to have the proper credentials to run Terraform Enterprise securely:

#### a. **Terraform Enterprise License**

* This is a paid product.
* You get the license from [HashiCorp's customer portal](https://portal.terraform.io).

#### b. **TLS Certificate and Private Key**

* Needed for HTTPS (secure web access).
* You must **generate and supply your own certificate** (self-signed or from a CA like Let's Encrypt).

---

### 🐧 **3. Linux Instance**

Terraform Enterprise only runs on **Linux operating systems**. It does **not support Windows**.

#### ✅ **Supported Linux OS versions**:

* **Debian**: 7.7+
* **Ubuntu**: 14.04.5 / 16.04 / 18.04 / 20.04
* **Red Hat Enterprise Linux (RHEL)**: 7.4 – 7.9
* **CentOS**: 7.4 – 7.9
* **Amazon Linux**: 2014.03 → 2018.03, 2.0
* **Oracle Linux**: 7.4 – 7.9

---

### 🖥️ **Hardware Requirements**

Minimum requirements for installing and running Terraform Enterprise:

| Component                 | Requirement                            |
| ------------------------- | -------------------------------------- |
| 🧠 System Memory          | At least **8 GB** RAM                  |
| 💾 Root Volume Disk Space | At least **10 GB**                     |
| 📦 Docker Data Directory  | At least **40 GB** (`/var/lib/docker`) |
| 🧮 CPU                    | At least **4 cores**                   |

> ⚠️ These are **minimum specs**. For production use, higher specs may be needed based on load and usage.

---

### ✅ Summary Table

| Category        | Requirement                                  |
| --------------- | -------------------------------------------- |
| **Mode**        | External services / Mounted disk / Demo      |
| **Credentials** | TFE License, TLS Certificate & Private Key   |
| **OS**          | Only Linux (various distributions supported) |
| **Hardware**    | 8 GB RAM, 40 GB Docker Disk, 4 CPU cores     |

---

Let me know if you'd like:

* 🧭 A **setup diagram**
* 📦 Examples of **airgap vs online** mode
* ✅ A checklist for **Terraform Enterprise installation**
