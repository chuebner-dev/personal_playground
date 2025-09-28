# AWS Setup for GitHub Actions OIDC

This document outlines the steps required to configure an AWS account to allow GitHub Actions to deploy resources using Terraform and OpenID Connect (OIDC). This method is more secure than using long-lived AWS credentials.

Follow these steps for each AWS account (e.g., dev, prod) you want to deploy to.

## 1. Create the OIDC Identity Provider

1.  Navigate to **IAM > Identity providers** in the AWS Management Console.
2.  Click **Add provider**.
3.  For the **Provider type**, select **OpenID Connect**.
4.  For the **Provider URL**, enter `https://token.actions.githubusercontent.com`.
5.  For the **Audience**, enter `sts.amazonaws.com`.
6.  Click **Add provider**.

## 2. Create the IAM Role

1.  Navigate to **IAM > Roles** and click **Create role**.
2.  For the **Trusted entity type**, select **Web identity**.
3.  Under **Identity provider**, choose the provider you just created (`token.actions.githubusercontent.com`).
4.  For the **Audience**, select `sts.amazonaws.com`.
5.  Optionally, you can specify the GitHub organization, repository, and branch that should be allowed to assume this role. For this project, you need to allow your repository.
    *   **GitHub organization**: Your GitHub username or organization name.
    *   **GitHub repository**: The name of this repository (`personal_playground`).
    *   You can also specify a branch, for example `main`.
6.  Click **Next**.
7.  Add the necessary permissions policies to the role. For the example in this repository, `AmazonS3FullAccess` would be sufficient to create the S3 bucket. In a real-world scenario, you should apply the principle of least privilege and grant only the permissions required by your Terraform configuration.
8.  Click **Next**.
9.  Give the role a name (e.g., `GitHubActionsRole-Terraform`).
10. Click **Create role**.

## 3. Configure the Trust Relationship

1.  After the role is created, navigate to its **Trust relationships** tab.
2.  Click **Edit trust policy**.
3.  You need to modify the `Condition` block to allow your repository to assume this role. The `sub` claim should be configured to match your repository.

Replace `<YOUR_GITHUB_USERNAME_OR_ORG>` with your actual GitHub username or organization name.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                },
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:<YOUR_GITHUB_USERNAME_OR_ORG>/personal_playground:*"
                }
            }
        }
    ]
}
```

4.  Click **Update policy**.

## 4. Create GitHub Environments and Secrets

1.  In your GitHub repository, go to **Settings > Environments**.
2.  Create two new environments: `dev` and `prod`.
3.  For each environment, you need to add an environment secret:
    *   **Name**: `AWS_ROLE_ARN`
    *   **Value**: The ARN of the IAM role you created in that specific AWS account (e.g., `arn:aws:iam::111122223333:role/GitHubActionsRole-Terraform` for dev and `arn:aws:iam::444455556666:role/GitHubActionsRole-Terraform` for prod).

Once you have completed these steps for both your `dev` and `prod` AWS accounts, the GitHub Actions workflow will be able to authenticate and deploy the Terraform resources accordingly.