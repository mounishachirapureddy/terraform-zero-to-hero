# terraform registry ~ docker hub

# Infrastructure as Code(IaC)

Before the advent of IaC, infrastructure management was typically a manual and time-consuming process. System administrators and operations teams had to:

1. Manually Configure Servers: Servers and other infrastructure components were often set up and configured manually, which could lead to inconsistencies and errors.

2. Lack of Version Control: Infrastructure configurations were not typically version-controlled, making it difficult to track changes or revert to previous states.

3. Documentation Heavy: Organizations relied heavily on documentation to record the steps and configurations required for different infrastructure setups. This documentation could become outdated quickly.

4. Limited Automation: Automation was limited to basic scripting, often lacking the robustness and flexibility offered by modern IaC tools.

5. Slow Provisioning: Provisioning new resources or environments was a time-consuming process that involved multiple manual steps, leading to delays in project delivery.

IaC addresses these challenges by providing a systematic, automated, and code-driven approach to infrastructure management. Popular IaC tools include Terraform, AWS CloudFormation, Azure Resource Manager templates others. 

These tools enable organizations to define, deploy, and manage their infrastructure efficiently and consistently, making it easier to adapt to the dynamic needs of modern applications and services.

# Why Terraform ?
# API as code-- HCL templates are converted to api to talk with cloud providers.terraform applies this code and uses this api to create infrastructure

There are multiple reasons why Terraform is used over the other IaC tools but below are the main reasons.

1. **Multi-Cloud Support**: Terraform is known for its multi-cloud support. It allows you to define infrastructure in a cloud-agnostic way, meaning you can use the same configuration code to provision resources on various cloud providers (AWS, Azure, Google Cloud, etc.) and even on-premises infrastructure. This flexibility can be beneficial if your organization uses multiple cloud providers or plans to migrate between them.

2. **Large Ecosystem**: Terraform has a vast ecosystem of providers and modules contributed by both HashiCorp (the company behind Terraform) and the community. This means you can find pre-built modules and configurations for a wide range of services and infrastructure components, saving you time and effort in writing custom configurations.

3. **Declarative Syntax**: Terraform uses a declarative syntax, allowing you to specify the desired end-state of your infrastructure. This makes it easier to understand and maintain your code compared to imperative scripting languages.

4. **State Management**: Terraform maintains a state file that tracks the current state of your infrastructure. This state file helps Terraform understand the differences between the desired and actual states of your infrastructure, enabling it to make informed decisions when you apply changes.

5. **Plan and Apply**: Terraform's "plan" and "apply" workflow allows you to preview changes before applying them. This helps prevent unexpected modifications to your infrastructure and provides an opportunity to review and approve changes before they are implemented.

6. **Community Support**: Terraform has a large and active user community, which means you can find answers to common questions, troubleshooting tips, and a wealth of documentation and tutorials online.

7. **Integration with Other Tools**: Terraform can be integrated with other DevOps and automation tools, such as Docker, Kubernetes, Ansible, and Jenkins, allowing you to create comprehensive automation pipelines.

8. **HCL Language**: Terraform uses HashiCorp Configuration Language (HCL), which is designed specifically for defining infrastructure. It's human-readable and expressive, making it easier for both developers and operators to work with.


---
Sure! Here's a **very simple explanation** of **Declarative vs Imperative IaC**:
**terraform is declarative but terraform language features imperative like functionality**
---

### 🟩 **Declarative IaC = "What you want"**

> You tell the tool:
> “I want a server with 2GB RAM and Ubuntu.”
>
> ✅ The tool **figures out how** to make that happen.

🛠 **Example:**

* "I want 1 VM in AWS with Ubuntu."
* Tool (like Terraform) creates or updates the VM as needed.

---

### 🟦 **Imperative IaC = "How to do it"**

> You tell the tool:
> “Step 1: Create VM. Step 2: Install Ubuntu. Step 3: Set 2GB RAM.”
>
> ✅ You write **all steps** yourself.

🛠 **Example:**

* Write a script:

  ```bash
  aws ec2 run-instances --image-id ami-ubuntu --instance-type t2.small
  ```

---

### ✅ Simple Comparison:

| Feature        | Declarative   | Imperative                |
| -------------- | ------------- | ------------------------- |
| You write      | What you want | How to do it step by step |
| Example        | Terraform     | Bash script or Ansible    |
| Easy to change | Yes           | Sometimes hard            |

---

Let me know if you want a funny example using real life like “ordering food” 🍕 vs “cooking food” 👩‍🍳 — that works great too!
---
Here’s an **easy-to-understand comparison** of **Declarative vs Imperative IaC** with their **advantages and disadvantages**:

---

### 🟩 **Declarative IaC**

🧾 **You declare what the final setup should look like**, and the tool makes it happen.

#### ✅ Advantages:

1. **Simple to manage** – You focus on *what you need*, not how to get it.
2. **Idempotent** – Running it again won't break things. Tool checks current state and only changes what's needed.
3. **Easier to scale** – Better for managing large environments.
4. **Automatic handling** – The tool figures out how to apply changes.

#### ❌ Disadvantages:

1. **Less control** – You don’t decide the exact order of steps.
2. **Harder to debug** – If something goes wrong, it may not be clear which step caused it.
3. **Learning curve** – Tools like Terraform have their own syntax (HCL), which takes time to learn.

---

### 🟦 **Imperative IaC**

🧾 **You write all the steps to reach the final setup**.

#### ✅ Advantages:

1. **Full control** – You choose what happens and in what order.
2. **Easy to understand for beginners** – Like writing bash scripts or command-line steps.
3. **Good for simple or one-time tasks** – Quick and straightforward.

#### ❌ Disadvantages:

1. **Not idempotent** – Running the script again might cause errors or duplicate resources.
2. **Hard to maintain** – You have to manually track what was done.
3. **Doesn’t track state** – No built-in way to know current infrastructure state.
4. **More error-prone** – Easy to forget a step or make a mistake in ordering.

---

### 📊 Summary Table

| Feature               | Declarative IaC       | Imperative IaC               |
| --------------------- | --------------------- | ---------------------------- |
| Focus                 | What you want         | How to do it                 |
| Control               | Less                  | More                         |
| State management      | Yes (tool handles it) | No (you handle it)           |
| Easy to repeat safely | ✅ Yes                 | ❌ No (can fail or duplicate) |
| Learning curve        | Medium                | Easy                         |
| Best for              | Large, complex setups | Simple or short tasks        |

---

Let me know if you want a **real-life example** (like ordering pizza vs making pizza)!
