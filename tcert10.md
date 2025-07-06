# Expressions – Operators


Operators are **mathematical operations** you can perform on numbers within expressions:

- **Multiplication**: `a * b`
- **Division**: `a / b`
- **Modulus**: `a % b`
- **Addition**: `a + b`
- **Subtraction**: `a - b`
- **Flip to Negative (* -1)**: `-a`
- **Equals**: `a == b`
- **Does not Equal**: `a != b`
- **Less Than**: `a < b`
- **Less Than or Equal**: `a <= b`
- **Greater Than**: `a > b`
- **Greater Than or Equal**: `a >= b`
- **Or**: `a || b`
- **And**: `a && b`
- **Flip Boolean**: `!a`
---
Here’s a detailed explanation and the Markdown version of the slide shown in the image regarding **Conditional Expressions** in Terraform:

---

### 📘 **Conditional Expressions in Terraform**

Terraform supports **ternary if-else expressions** similar to many programming languages like JavaScript or Python.

#### 🔹 **Syntax Format:**

```hcl
condition ? true_val : false_val
```

* `condition`: A boolean expression that evaluates to `true` or `false`.
* If the condition is `true`, the result is `true_val`; otherwise, it's `false_val`.

---

### 🧪 **Example 1 – Simple Condition Check:**

```hcl
var.a != "" ? var.a : "default-a"
```

**Explanation:**

* This checks if the variable `var.a` is not empty (`!= ""`).
* If true, it returns the value of `var.a`.
* If false, it returns `"default-a"`.

Useful for setting default values when a variable might be unset or empty.

---

### ⚠️ **Important Rule: Same Return Type**

The return values of the **`true_val`** and **`false_val`** must be of the **same type**.

---

### 🧪 **Example 2 – Type Mismatch Issue:**

```hcl
var.example ? tostring(12) : "hello"
```

**Problem:**

* `tostring(12)` returns a string (`"12"`), and `"hello"` is also a string — so this is **valid**.
* But if the types were different (e.g., a string and a number), it would **cause an error**.

---

### ✅ Good Practice:

Always ensure that **both outcomes** of the ternary condition **return the same type** (string, number, list, etc.).

---

### 📝 Markdown Version

````md
# Conditional Expressions

_Cheat sheets, Practice Exams and Flash cards 👉 www.exampro.co/terraform_

Terraform supports **ternary if else** conditions:

```hcl
condition ? true_val : false_val
````

## Example:

```hcl
var.a != "" ? var.a : "default-a"
```

* If `var.a` is not empty, it returns `var.a`.
* Otherwise, it returns `"default-a"`.

---
Here's a clear explanation of the **Terraform For Expressions** slide from the image:

---

## 🧾 **Expressions – For Expressions in Terraform**

Terraform's **`for` expressions** let you iterate over complex data types (like lists, maps, etc.) and **transform** their values.

---

### ✅ **Accepted Input Types:**

A `for` expression can accept:

* **List**
* **Set**
* **Tuple**
* **Map**
* **Object**

---

### 🔠 **Example: Uppercase Strings in a List**

```hcl
[for s in var.list : upper(s)]
```

* This takes each item `s` from `var.list`, converts it to uppercase, and returns a **new list**.
* ✅ Example Output:
  `["HELLO", "WORLD"]`

---

### 🔑 **Example: Get Key and Value from Map**

```hcl
[for k, v in var.map : length(k) + length(v)]
```

* Iterates through each key-value pair in `var.map`.
* Returns the sum of the lengths of each key and value.

---

### 🔢 **Example: Get Index and Value from List**

```hcl
[for i, v in var.list : "${i} is ${v}"]
```

* `i` is the index, `v` is the value.
* ✅ Example Output:
  `["0 is hello", "1 is world"]`

---

### 🟨 **Output Format Based on Brackets:**

| Bracket Type | Returns      | Example Syntax                        | Example Output                       |
| ------------ | ------------ | ------------------------------------- | ------------------------------------ |
| `[ ]`        | Tuple (List) | `[for s in var.list : upper(s)]`      | `["HELLO", "WORLD"]`                 |
| `{ }`        | Object (Map) | `{for s in var.list : s => upper(s)}` | `{hello = "HELLO", world = "WORLD"}` |

---

### 📌 Summary:

* Use `for` expressions to **transform data** while iterating.
* You can extract:

  * Just values
  * Key/value pairs from maps
  * Index and value from lists
* Decide output **type** using square (`[]`) or curly (`{}`) brackets.

---

### 📝 Markdown Version

````md
# Expressions – For Expressions

_For expressions allow you to iterate over a complex type and apply transformations._

A `for` expression can accept input as **a list, a set, a tuple, a map, or an object**.

## 🔠 Uppercase Example
```hcl
[for s in var.list : upper(s)]
````

➡️ Output: `["HELLO", "WORLD"]`

## 🔑 Key & Value from Map

```hcl
[for k, v in var.map : length(k) + length(v)]
```

## 🔢 Index from List

```hcl
[for i, v in var.list : "${i} is ${v}"]
```

## 🟨 Bracket Meaning

* Square `[ ]` returns a **tuple (list)**:

```hcl
[for s in var.list : upper(s)]
```

* Curly `{ }` returns an **object (map)**:

```hcl
{for s in var.list : s => upper(s)}
```

➡️ Output: `{ hello = "HELLO", world = "WORLD" }`

```

Let me know if you'd like this saved as a `.md`, `.pdf`, or in code format for Terraform projects.
```
Here's a detailed explanation of the slide on **Terraform For Expressions with Conditions** from the image:

---

## 🔁 **Expressions – For Expressions (with Condition)**

In Terraform, a `for` expression can include an **`if` condition** to **filter** or **reduce** the number of elements returned in the result.

---

### ✅ **Conditional For Expression Syntax**

```hcl
[for s in var.list : upper(s) if s != ""]
```

**Explanation:**

* Iterates over each element `s` in `var.list`.
* Includes only elements **that are not empty** (`s != ""`).
* Applies the `upper()` function to each included element.
* Result is a **list** of uppercase strings **excluding empty values**.

---

### 🧠 **Use Case**

This is helpful when you want to **transform a list while ignoring or filtering out certain values** based on conditions.

---

### ⚙️ **Implicit Element Ordering on Conversion**

Terraform can convert unordered types (like `maps`, `sets`, and `objects`) into ordered types (`lists`, `tuples`) during evaluation. In such cases, it applies **implied ordering**:

* **Maps and Objects** ➝ Ordered by **key (A → Z)**
* **Sets of Strings** ➝ Ordered by **string value (A → Z)**

> This matters because Terraform needs consistent ordering when converting types — especially in expressions and plans.

---

### 📝 Markdown Version

````md
# Expressions – For Expressions (with Condition)

Terraform allows `if` statements inside `for` expressions to filter/reduce elements.

## Example
```hcl
[for s in var.list : upper(s) if s != ""]
````

* Iterates over `var.list`
* Transforms non-empty items to uppercase
* Skips any empty string elements

---

## Implicit Element Ordering on Conversion

When Terraform converts unordered types to ordered ones, it applies default sorting:

* **Maps and Objects**: ordered by key (A–Z)
* **Sets of Strings**: ordered by value (A–Z)

```

---

Let me know if you'd like all these notes compiled into one `.md` or `.pdf` study sheet for Terraform Expressions!
```
Here's the simplified and clear content from the slide on **Splat Expressions** in Terraform, with a short explanation:

---

## 🌟 **Expressions – Splat Expressions**

A **splat expression** gives a **shorter way to write `for` expressions**.

---

### 🔸 **What is a Splat Operator?**

* Represented by an asterisk (`*`)
* Originates from the Ruby language
* Helps **loop over lists/sets/tuples** to extract values easily
  *(Used instead of writing full `for` loops)*

---

### 🔍 **Example – Without Splat:**

```hcl
[for o in var.list : o.id]
[for o in var.list : o.interfaces[0].name]
```

This manually loops over each element `o` in the list.

---

### ✅ **Same Example – Using Splat:**

```hcl
var.list[*].id
var.list[*].interfaces[0].name
```

This gives the **same result**, but is **shorter and cleaner**.

---

### 📝 Markdown Version

````md
# Expressions – Splat Expressions

A splat expression gives a **shorter expression** for `for` loops.

## What is a splat operator?
- Uses a `*` (asterisk)
- Helps loop over lists or objects
- Makes expressions simpler and shorter

---

## Without splat (long form):
```hcl
[for o in var.list : o.id]
[for o in var.list : o.interfaces[0].name]
````

---

## With splat (short form):

```hcl
var.list[*].id
var.list[*].interfaces[0].name
```

➡️ **Same result, less code!**

```

Let me know if you want a complete `.md` or `.pdf` of all these Terraform expressions!
```


## Important:

The return type for both the `true_val` and `false_val` **must be the same type**.

### Example:

```hcl
var.example ? tostring(12) : "hello"
```

✅ Valid because both outcomes are **strings**.

```

Let me know if you'd like to save it as a `.md` or `.pdf` file!
```
