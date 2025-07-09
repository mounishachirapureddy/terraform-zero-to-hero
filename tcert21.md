Here is the content from your screenshot about **Terraform Cloud**:

---

## **Terraform Cloud**

**Terraform Cloud** is an application that helps teams use Terraform together.

### ✅ Features:

* Manages your state files
* History of previous runs
* History of previous states
* Easy and secure variable injection
* Tagging
* Run Triggers (chaining workspaces)
* Specify any version of Terraform per workspace
* Global state sharing
* Commenting on Runs
* Notifications via Webhooks, Email, Slack
* Organization and Workspace Level Permissions
* **Policy as Code** (via Sentinel Policy Sets)
* **MFA** (Multi-Factor Authentication)
* **SSO** (Single Sign-On – at Business tier)
* Cost Estimation (at Teams and Governance tier)
* Integrations with ServiceNow, Splunk, K8s, and custom run tasks

---

Let me know if you want this added to your Terraform notes or explained further.
Perfect! Let’s now add **Teams** to the list and show you how it fits into the Terraform Cloud structure.

---

## 🌐 Terraform Cloud – Key Terms Explained

---

### 🔸 1. **Organization**

* The **top-level structure** in Terraform Cloud.
* Groups all related **workspaces**, **teams**, and **users**.
* Every Terraform Cloud account operates inside at least one organization.

> 📌 Example:
> An organization called `acme-corp` holds all cloud infrastructure work for Acme Corp.

---

### 🔸 2. **Workspace**

* A **Terraform working directory** inside an organization.
* It manages:

  * Terraform configuration
  * Terraform state
  * Variables
  * Run history
* Usually maps to **one environment or stack** (e.g., dev, staging, prod).

> 📌 Example:
> `web-app-dev`, `web-app-prod` — two workspaces for separate environments.

---

### 🔸 3. **Run**

* A **Terraform execution event** triggered inside a workspace.
* Includes:

  * `Plan`: Show what Terraform will do.
  * `Apply`: Make those changes in cloud infra.
* Runs can be:

  * **Auto-triggered** (via Git)
  * **Manually triggered** (via UI or CLI)
  * **API-triggered**

> 📌 Example:
> A run may say: "Terraform will add 1 resource, change 2, and delete 1."

---

### 🔸 4. **Team**

* A group of **users with shared permissions**.
* Used to **manage access control** for:

  * Organizations
  * Workspaces
* Each team can have:

  * **Read**, **Write**, **Plan**, **Apply**, or **Admin** access
  * Assigned to one or multiple workspaces

> 📌 Example:
>
> * `DevOps Team` has full access to all environments.
> * `QA Team` has read-only access to staging environment.

---

### 🔄 Full Relationship:

```
Organization
├── Teams
│   ├── Users
│   └── Permissions for Workspaces
└── Workspaces
    └── Runs (Plan + Apply)
```

---

Would you like a **real use case** or **diagram** based on this?
Absolutely! In **Terraform Cloud**, there are **three main types of workflows** you can use to manage and deploy infrastructure:

---

## 🔁 Terraform Cloud Workflows (in Detail)

There are **3 primary workflows** in Terraform Cloud:

| Workflow Type     | Description                                     | Best For                         |
| ----------------- | ----------------------------------------------- | -------------------------------- |
| 1. **CLI-Driven** | Use Terraform CLI locally, but backend is Cloud | Developers/testers using CLI     |
| 2. **VCS-Driven** | Auto-trigger runs on Git commits                | Teams using Git-based automation |
| 3. **API-Driven** | Use REST API to trigger runs                    | Custom tools, CI/CD pipelines    |

---

### 🔸 1. **CLI-Driven Workflow**

**✅ Use case**: You run Terraform commands from your **local terminal**, but the **Terraform Cloud handles the state file**, secrets, and applies remotely.

#### 🔧 How It Works:

* You configure Terraform Cloud as the **backend**:

  ```hcl
  terraform {
    backend "remote" {
      organization = "acme-corp"
      workspaces {
        name = "dev-environment"
      }
    }
  }
  ```
* Then run from local:

  ```bash
  terraform init
  terraform plan
  terraform apply
  ```

#### 📦 Features:

* You **control the workflow** from your local machine.
* **Remote backend**: Terraform Cloud stores your state securely.
* You get **remote runs**, **logging**, **team visibility**, etc.

#### 🚫 When Not to Use:

* When you want full automation on every code push.
* If developers are not allowed to run CLI commands locally.

---

### 🔸 2. **VCS-Driven Workflow (Git-based)**

**✅ Use case**: Your Terraform Cloud **automatically runs** when you push code to GitHub, GitLab, Bitbucket, etc.

#### 🔧 How It Works:

* You connect a **Version Control System (VCS)** to Terraform Cloud.
* Every time you `git push`, Terraform Cloud:

  1. Fetches the updated code.
  2. Runs `terraform plan` and waits for approval.
  3. Applies changes (if you approve).

> It supports **GitHub, GitLab, Bitbucket, Azure Repos**, etc.

#### 📦 Features:

* **Fully automated**.
* Code is the **single source of truth**.
* Helps with **collaboration and approvals**.
* Shows diffs in Terraform Cloud UI.

#### ✅ Best For:

* **Infrastructure as Code (IaC)** teams.
* PR-based workflows (collaboration, approvals).

#### 🚫 When Not to Use:

* You don’t use VCS or need programmatic run control (e.g., in CI/CD).

---

### 🔸 3. **API-Driven Workflow**

**✅ Use case**: You want to **trigger Terraform runs programmatically** — from a CI/CD pipeline (like Jenkins, GitHub Actions), custom scripts, or other systems.

#### 🔧 How It Works:

* You use **Terraform Cloud's REST API** to:

  1. Upload configuration versions (Terraform code).
  2. Trigger runs.
  3. Monitor results.
* Example API call to start a run:

  ```bash
  curl \
    --header "Authorization: Bearer <API_TOKEN>" \
    --request POST \
    --data '{...}' \
    https://app.terraform.io/api/v2/runs
  ```

#### 📦 Features:

* Full **programmatic control**.
* Great for **CI/CD integrations**.
* You can trigger runs from **external systems** (e.g., after a database migration).

#### ✅ Best For:

* **Enterprise DevOps** teams.
* Integrating with tools like Jenkins, CircleCI, Azure DevOps.

#### 🚫 When Not to Use:

* For smaller teams who don’t need custom workflows or full automation.

---

## 🔁 Summary Table

| Feature / Workflow  | CLI-Driven           | VCS-Driven      | API-Driven              |
| ------------------- | -------------------- | --------------- | ----------------------- |
| Trigger Method      | Local CLI            | Git Push / PR   | REST API call           |
| Who runs Terraform? | Local user           | Terraform Cloud | Terraform Cloud         |
| Infra state stored  | Terraform Cloud      | Terraform Cloud | Terraform Cloud         |
| Best For            | Manual use / testing | Teams using Git | CI/CD & automation      |
| Example Tool Pair   | Terminal, VSCode     | GitHub, GitLab  | Jenkins, GitHub Actions |

---

Would you like a **diagram** comparing the 3 workflows visually?
This screenshot explains **Terraform Cloud – Organization-Level Permissions**.

---

## 🏢 Organization-Level Permissions in Terraform Cloud

These permissions **apply to the entire organization** (not just one workspace or team):

### 🔐 **Main Permissions:**

1. **Manage Policies**
   → Create, edit, delete Sentinel policies (rules for enforcing compliance).

2. **Manage Policy Overrides**
   → Allow users to override mandatory Sentinel checks if needed.

3. **Manage Workspaces**
   → Create and manage all workspaces inside the organization.

4. **Manage VCS Settings**
   → Control version control system (e.g., GitHub) integrations and SSH keys.

---

### 👑 **Organization Owners**

Every organization must have at least one **Owner**. This role has **full control** and exclusive permissions like:

* ✅ Publish private Terraform modules
* ✅ Invite new users to the organization
* ✅ Manage teams and their membership
* ✅ View all **secret variables**
* ✅ Control all org-wide permissions/settings
* ✅ Control **billing** and payment settings
* ✅ **Delete** the entire organization if needed

---

### 🔑 Summary

| **Scope**   | **Permission Type**              | **Who Can Do It?**              |
| ----------- | -------------------------------- | ------------------------------- |
| Whole Org   | Manage policies, VCS, workspaces | Users with elevated permissions |
| Owners Only | Secrets, billing, deletion       | **Organization Owners only**    |

Let me know if you want a table format or a mind map!
This screenshot explains **Terraform Cloud – Workspace-Level Permissions**.

---

## 🧱 Workspace-Level Permissions

These permissions **apply only to a specific workspace** inside an organization — unlike **organization-level permissions**, which apply globally.

---

### 🔧 General Workspace Permissions (Custom)

These are **granular permissions** you can assign to users or teams via **custom permission sets**:

* ✅ **Read runs** – View past Terraform runs
* ✅ **Queue plans** – Start a new plan
* ✅ **Apply runs** – Approve and execute changes
* ✅ **Lock/unlock workspaces** – Prevent others from running while you're editing
* ✅ **Download Sentinel mocks** – Used for policy testing
* ✅ **Read variable** – View a single variable
* ✅ **Read/write variables** – Modify variable values
* ✅ **Read state outputs** – View the output section of Terraform state
* ✅ **Read state versions** – View history of state changes
* ✅ **Read/write state versions** – Modify or restore past states

---

### 🎯 Fixed Permission Sets (Quick Assign)

Instead of setting individual permissions, Terraform Cloud provides **preset roles**:

#### 🔹 **Read**

* Read runs
* Read variables
* Read state versions

#### 🔹 **Plan**

* Queue plans
* Read variables
* Read state versions

#### 🔹 **Write**

* Apply runs
* Lock/unlock workspaces
* Download Sentinel mocks
* Read/write variables
* Read/write state versions

---

### 👑 Workspace Admins

A **Workspace Admin** has **full control over that workspace**, including:

* ✅ Read and write **workspace settings**
* ✅ Set or remove **permissions for any team**
* ✅ **Delete** the workspace entirely

---

### ✅ Summary Comparison:

| **Role**                     | **What they can do**                                                     |
| ---------------------------- | ------------------------------------------------------------------------ |
| Custom Permissions           | Fine-grained control over actions (read, write, plan)                    |
| Fixed Sets (Read/Plan/Write) | Predefined combinations of actions for ease                              |
| Workspace Admin              | Full control over workspace including settings and permission management |

---

Let me know if you want a comparison between **Workspace** and **Organization** permissions!
This slide explains the **three types of API tokens** in **Terraform Cloud**, which are used for authenticating API requests securely.

---

## 🔐 Terraform Cloud – API Tokens

Terraform Cloud supports **3 types of API Tokens**:

1. **User API Tokens**
2. **Team API Tokens**
3. **Organization API Tokens**

---

### 1️⃣ **Organization API Tokens**

* 🔒 Have **full access** across the **entire organization**
* 🧩 Each organization can only have **one valid API token** at a time
* 👑 Only **organization owners** can generate or revoke them
* 🏗️ Mainly used to:

  * Create/configure **workspaces**
  * Manage **teams**
* ⚠️ **Not recommended** for general use — intended for **automated setup**, not day-to-day actions

---

### 2️⃣ **Team API Tokens**

* 🛠️ Allow access to workspaces a team has access to
  (but not tied to a specific user)
* Each team can have **one valid token**
* Any team member can create or revoke the team’s token
* 🔁 Regenerating it makes the old one **invalid**
* 🎯 Used for **automated tasks** on workspaces (API operations)

---

### 3️⃣ **User API Tokens**

* 🌐 **Most flexible** token
* Inherit permissions of the **user they are linked to**
* Can be used by real users or **machine users** (automation accounts)
* 🔄 Useful for CLI, automation, and personal use

---

### ✅ Summary Table:

| Token Type     | Scope                         | Who Creates It      | Use Case                          |
| -------------- | ----------------------------- | ------------------- | --------------------------------- |
| **User Token** | Same as user permissions      | The user themselves | CLI, automation, personal tasks   |
| **Team Token** | Access to team's workspaces   | Any team member     | Automating team-level actions     |
| **Org Token**  | Full organization-wide access | Org Owner only      | Setup/config of org-wide settings |

---

Let me know if you want a visual summary or cheat sheet for all Terraform Cloud concepts!
