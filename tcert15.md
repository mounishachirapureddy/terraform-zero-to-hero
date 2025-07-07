This image is a screenshot from a YouTube video explaining how to **debug Terraform** by enabling logging through environment variables. Here's a detailed explanation of the contents:

---

### 🔍 **Topic**: Debugging Terraform

Terraform can generate detailed logs to help with debugging. These logs are controlled through environment variables.

---

### 🔧 **Key Environment Variables**:

1. **`TF_LOG`**:

   * This is the main variable used to control logging verbosity.
   * Possible values (from most to least verbose):

     * `TRACE` – Very detailed, low-level information.
     * `DEBUG` – Debug-level info.
     * `INFO` – General operational information.
     * `WARN` – Warnings about potentially problematic behavior.
     * `ERROR` – Only error messages.
     * `JSON` – Same level as `TRACE`, but formatted as JSON for easier machine parsing.

2. **`TF_LOG_CORE`**:

   * Enables logging for the Terraform core engine specifically.
   * Accepts same values as `TF_LOG`.

3. **`TF_LOG_PROVIDER`**:

   * Enables logging for provider-specific operations.
   * Also accepts same values as `TF_LOG`.

4. **`TF_LOG_PATH`**:

   * This variable specifies the file path where the log output should be written.
   * If not set, logs are printed to the terminal.

---

### 📋 **Log Output Example** (in the black terminal box):

This part of the image shows an example Terraform log with entries tagged like:

* `[TRACE]` — Indicates very detailed debugging information.
* Shows plugin loading, schema retrieval, plugin exit, validation, etc.

---

### ✅ **Use Case**:

Set the environment variables before running Terraform commands to capture logs. For example, in a shell:

```bash
export TF_LOG=DEBUG
export TF_LOG_PATH=terraform.log
terraform plan
```

This will write debug logs to a file named `terraform.log`.

---

### 📚 Source:

This is from a video titled **"HashiCorp Terraform Associate Certification Course"** by *freeCodeCamp.org*. It is useful for preparing for the Terraform Associate certification.

---

Would you like a short shell script example or Windows command for using these variables?
