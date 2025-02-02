## **Terraform AWS ECS Infrastructure**

This repository contains Terraform configurations to deploy a server-based infrastructure on AWS using **Amazon ECS (Elastic Container Service)**. The infrastructure includes:

- A **VPC** with 2 public and 2 private subnets.
- An **ECS cluster** deployed in the VPC.
- An **ECS task/service** running a container in the private subnets.
- An **Application Load Balancer (ALB)** deployed in the public subnets to expose the service.

---

## **Prerequisites**

Before using this Terraform configuration, ensure you have the following:

1. **AWS Account**:
   - An AWS account with sufficient permissions to create resources like VPC, ECS, ALB, IAM roles, etc.

2. **AWS CLI**:
   - Install the [AWS CLI](https://aws.amazon.com/cli/) and configure it with your credentials:
     ```bash
     aws configure
     ```
   - Provide your AWS Access Key, Secret Key, default region, and output format.

3. **Terraform**:
   - Install [Terraform](https://www.terraform.io/downloads.html) (v1.0 or higher recommended).

4. **Git**:
   - Install [Git](https://git-scm.com/) to clone this repository.

---

## **Project Structure**

The repository is structured as follows:

```
terraform/
├── main.tf                      
├── outputs.tf           
├── terraform.tfvars     
├── README.md       
└── .gitignore           
```

---

## **Deployment Instructions**

Follow these steps to deploy the infrastructure:

### **1. Clone the Repository**
Clone this repository to your local machine:
```bash
git clone https://github.com/yourusername/terraform-ecs-infra.git
cd terraform-ecs-infra
```

### **2. Initialize Terraform**
Initialize Terraform to download the required providers and modules:
```bash
terraform init
```

### **3. Review the Plan**
Review the execution plan to see what resources Terraform will create:
```bash
terraform plan
```

### **4. Apply the Configuration**
Deploy the infrastructure:
```bash
terraform apply
```
Confirm the action by typing `yes` when prompted.

---

## **Verification**

After deployment, verify that the infrastructure was created successfully using the following AWS CLI commands:

### **1. Verify the VPC and Subnets**
```bash
aws ec2 describe-vpcs --filters "Name=tag:Name,Values=my-vpc"
aws ec2 describe-subnets --filters "Name=vpc-id,Values=<VPC_ID>"
```

### **2. Verify the ECS Cluster**
```bash
aws ecs describe-clusters --clusters my-ecs-cluster
```

### **3. Verify the ECS Task Definition**
```bash
aws ecs describe-task-definition --task-definition my-task
```

### **4. Verify the ECS Service**
```bash
aws ecs describe-services --cluster my-ecs-cluster --services my-service
```

### **5. Verify the Load Balancer**
```bash
aws elbv2 describe-load-balancers --names my-lb
aws elbv2 describe-target-groups --names my-target-group
```

### **6. Verify the IAM Role**
```bash
aws iam get-role --role-name ecs-task-execution-role
aws iam list-attached-role-policies --role-name ecs-task-execution-role
```

---

## **Outputs**

After running `terraform apply`, the following outputs will be displayed:

- **Load Balancer DNS Name**: The DNS name of the Application Load Balancer (ALB) to access the service.
  ```bash
  Outputs:
  load_balancer_dns = "my-lb-1234567890.us-west-2.elb.amazonaws.com"
  ```

---

## **Cleanup**

To avoid incurring unnecessary charges, destroy the infrastructure after testing:

```bash
terraform destroy
```
Confirm the action by typing `yes` when prompted.

---

## **Configuration Details**

### **Variables**
The following variables are defined in `variables.tf`:

| Variable Name       | Description                          | Default Value       |
|---------------------|--------------------------------------|---------------------|
| `aws_region`        | AWS region to deploy resources       | `"us-east-1"`       |
| `container_image`   | Docker image to deploy               | `"nginx:latest"`    |

You can override these variables in `terraform.tfvars` or via the command line:
```bash
terraform apply -var="aws_region=us-east-1"
```

---

## **Terraform Best Practices**

1. **Modularity**:
   - The VPC is created using the official [Terraform AWS VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws).

2. **Security**:
   - ECS tasks run in private subnets, and the ALB is deployed in public subnets to ensure secure access.

3. **IAM Role**:
   - An IAM role is created for ECS task execution, with permissions to pull Docker images and write logs.

4. **State Management**:
   - Terraform state is stored locally in `terraform.tfstate`. For production, consider using remote state storage (e.g., S3).

---

## **Troubleshooting**

### **1. Terraform Plan/Apply Fails**
- Ensure your AWS credentials are correctly configured using `aws configure`.
- Verify that your IAM user has sufficient permissions to create resources.

### **2. ECS Tasks Not Running**
- Check the ECS service events for errors:
  ```bash
  aws ecs describe-services --cluster my-ecs-cluster --services my-service
  ```
- Ensure the Docker image specified in `container_image` is valid and accessible.

### **3. Load Balancer Not Accessible**
- Verify that the ALB security group allows inbound traffic on port 80.
- Check the target group health checks:
  ```bash
  aws elbv2 describe-target-health --target-group-arn <TARGET_GROUP_ARN>
  ```

---

## **Contributing**

If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.

---

## **License**

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## **Contact**

For questions or feedback, feel free to reach out:

- **Name**: Aman Choudhary
- **Email**: caman.neo01@gmail.com
- **GitHub**: [amankc-neo](https://github.com/amankc-neo)

---

