variable "avx_admin_username" {
    type = string
    description = "Aviatrix Controller Admin"
}

variable "avx_admin_password" {
    type = string
    description = "Aviatrix Controller Password"
}

variable "avx_controller_ip" {
    type = string
    description = "Aviatrix Controller Address"
}

variable "avx_transit_gw" {
    type = string
    description = "Name of the Aviatrix Transit Gateway to attach"
}

variable "account_number" {
    type = string
    description = "AWS Account Number to add"
}
variable "access_key" {
    type = string
    description = "Access Key"
}

variable "secret_access_key" {
    type = string
    description = "Secret Access Key"
}

variable "region" {
    type = string
    description = "Region where to deploy the AWS Transit Network"
}
