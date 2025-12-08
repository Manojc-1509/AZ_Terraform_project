output "acr_login_server" {
  value = data.terraform_remote_state.shared.outputs.acr_login_server
}

output "acr_username" {
  value = data.terraform_remote_state.shared.outputs.acr_username
}

output "acr_password" {
  value = data.terraform_remote_state.shared.outputs.acr_password
}
