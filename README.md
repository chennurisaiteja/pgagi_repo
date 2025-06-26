

📦 DevOps Assignment – FastAPI + Next.js Full Stack App

This project is a containerized full-stack application with:

🔧 Backend: FastAPI

🎨 Frontend: Next.js

☁️ Deployed to AWS ECS (Fargate) using Terraform

🚀 Automated with GitHub Actions CI/CD

🛡️ Secure credentials via AWS Secrets Manager

📊 Monitoring with CloudWatch

🧪 Load balancing across multiple ECS containers

🗂️  Project Structure

    .
    ├── backend/                               
    │   └── Dockerfile                          
    ├── frontend/
    │   └── Dockerfile
    ├── infra/
    │   ├── main.tf (optional)
    │   ├── vpc.tf
    │   ├── ecs.tf
    │   ├── alb.tf
    │   ├── cloudwatch.tf
    │   ├── secrets.tf
    │   ├── iam.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    ├── .github/workflows/
    │   └── Build, Test, and Deploy to AWS ECR.yml


✅ Task 1 – Run the App Locally (Pre-containerization)

Prerequisites

Python 3.11

Node.js 18.x

pip, npm

Backend (FastAPI)

cd backend 

python3 -m venv venv 

source venv/bin/activate

pip install -r requirements.txt

uvicorn app.main:app --reload --port 8000

http://localhost:8000/api/health

http://localhost:8000/api/message

Frontend (Next.js)

cd frontend

npm install

npm run dev

Visit: http://localhost:3000

✅ Task 2 – Dockerization

Both services are containerized using multi-stage Dockerfiles.

Build and run with Docker Compose (optional local test)

docker-compose up --build

✅ Task 3 – CI/CD with GitHub Actions

CI/CD Flow

Trigger: On push to develop or main

Steps:

Checkout code

Run backend unit tests with Pytest

Run frontend E2E tests with Cypress

Build Docker images

Push to AWS ECR

Deploy to ECS 

File: .github/workflows/deploy.yml

Secrets Required:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_REGION

ECR_REPO_BACKEND

ECR_REPO_FRONTEND

✅ Task 4 – Infrastructure as Code (Terraform)

AWS Resources Provisioned:

VPC, Subnets

Security Groups

ECS Cluster (Fargate)

ECS Services + Task Definitions

ALB + Target Groups + Listeners

Secrets Manager

IAM roles with least privilege

Step-by-Step:

cd infra

terraform init

terraform plan

terraform apply -auto-approve

✅ Output: alb_dns_name – copy this to access the app.

✅ Task 5 – Monitoring & Alerting

📈 CloudWatch
Metrics collected:

CPU utilization

Memory usage

ALB request count

🔔 Alarms:
Configured CloudWatch alarm for:

High CPU > 70% for 5 minutes

Notification sent to email via SNS Topic

✅ Task 6 – Security Best Practices

🔐 IAM

ECS Task uses least-privilege IAM role

Allows:

Only necessary ECR actions

Logging to CloudWatch

Reading a specific secret from Secrets Manager

🔐 AWS Secrets Manager

Credentials (username, password, host) stored securely

Fetched into ECS task at runtime via secrets block in task definition

🔒 Network Restrictions

Security Group:

Ingress: TCP 8000 (backend), 3000 (frontend), only via ALB

Egress: All

✅ Task 7 – Load Balancing Validation

ECS Service Scaling

Both backend and frontend ECS services use:

desired_count = 2

Fargate tasks behind an Application Load Balancer

Validation:

Verified in Target Groups: 2 healthy tasks

Accessed endpoint:

curl http://<alb_dns_name>:8000/api/health
Stopped one task manually

Re-ran curl — traffic still served from remaining task

🎯 Load balancing works as expected!

📎 Cleanup

To destroy infrastructure:

terraform destroy -auto-approve

Ensure terraform.tfstate is not in .gitignore when applying/destroying.



