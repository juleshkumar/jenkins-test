output "workspace_account_name" {
  value = aws_organizations_account.account.id
  # sensitive   = true
  description = "Account ID"
  depends_on  = [aws_organizations_account.account]
}