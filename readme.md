# 🚀 Terraform AWS RDS Module

&#x20;&#x20;

> **Spin up a ready‑to‑use private MySQL RDS in seconds** — perfect for dev/test stacks.

- [1. Features](#1-%EF%B8%8F-features)
- [2. What gets created](#2-%EF%B8%8F-what-gets-created)
- [3. Prerequisites](#3-prerequisites)
- [4. Quick start](#4-quick-start)
- [5. Variables](#5-%EF%B8%8F-input-variables)
- [6. Outputs](#6-%EF%B8%8F-outputs)
- [7. Extending](#7-%EF%B8%8F-extending-the-module)
- [8. Security](#8-%EF%B8%8F-security-notes)
- [9. License](#9-license)

## 1. ✨ Features

- 💾 **MySQL 8.0** on `db.t3.micro` for low‑cost testing
- 🔒 Private subnets **only** — no public exposure
- 🛡️ Auto‑generated security group restricted to your web tier
- ♻️ Clean destroy with a single `terraform destroy`

## 2. 🏗️ What gets created

| 🧩 Resource           | Purpose                                          |
| --------------------- | ------------------------------------------------ |
| **DB Security Group** | Allows inbound MySQL (3306) from your *Web SG*   |
| **DB Subnet Group**   | Multi‑AZ grouping of private subnets             |
| **RDS Instance**      | Single‑AZ MySQL 8.0 database with 20 GiB storage |

## 3. 🔧 Prerequisites

- Terraform **≥ 1.7**
- AWS credentials with RDS & VPC privileges
- (Optional) Remote backend (S3 + DynamoDB) for state

## 4. 🚀 Quick start

```bash
git clone <your‑fork‑url> terraform-aws-rds && cd "$_"
cp terraform.tfvars.example terraform.tfvars   # fill in 🔑 secrets
terraform init
terraform plan -out rds.plan
terraform apply rds.plan
```

## 5. 📥 Input variables

| Variable             | 📖 Description                 | Type           | Example                         |
| -------------------- | ------------------------------ | -------------- | ------------------------------- |
| `lab_vpc_id`         | VPC hosting the DB             | `string`       | `"vpc-08eec6c8e951e1667"`       |
| `web_sg_id`          | Web tier security group        | `string`       | `"sg-0f48f2b6ea61a4003"`        |
| `private_subnet_ids` | **Private** subnets in ≥ 2 AZs | `list(string)` | `["subnet-0123","subnet-0456"]` |
| `db_username`        | Master user                    | `string`       | `"admin"`                       |
| `db_password`        | 🔒 Master password (sensitive) | `string`       | `"********"`                    |

## 6. 📤 Outputs

| Output         | Meaning                |
| -------------- | ---------------------- |
| `db_sg_id`     | ID of the DB SG        |
| `rds_endpoint` | Endpoint `<host>:3306` |

## 7. 🔄 Extending the module

- Enable **Multi‑AZ** by setting `multi_az = true`
- Swap to PostgreSQL with `engine = "postgres"`
- Add **Enhanced Monitoring** via `monitoring_interval`
- Integrate into CI/CD with `terraform cloud` or GitHub Actions

## 8. 🛡️ Security notes

> **Never** commit secrets or `*.tfstate` files.\
> Use AWS Secrets Manager + `TF_VAR_db_password` env vars for pipelines.

## 9. 📝 License

Licensed under **MIT**.

---

Made with 💜 & Terraform.

