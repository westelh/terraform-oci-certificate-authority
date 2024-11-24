variable "compartment_id" {
  description = "The OCID of the compartment."
  type = string
}

variable "name" {
  description = "The name of the CA."
  type = string
}

variable "description" {
  description = "The description of the CA."
  type = string
}

variable "key_management_endpoint" {
  description = "KMS vault endpoint to store encryption key for the CA."
  type = string
}

variable "type" {
  description = "The type of the CA."
  type = string
}

variable "signing_algorithm" {
  description = "The signing algorithm of the CA."
  type = string
}

variable "common_name" {
  description = "The common name of the CA."
  type = string
}

variable "distinguished_name_qualifier" {
  description = "The distinguished name qualifier of the CA."
  type = string
}

variable "ca_max_validity" {
  description = "The maximum validity of certificates issued for the CA."
  type = string
  default = "P3652D"
}

variable "leaf_max_validity" {
  description = "The maximum validity of leaf certificates"
  type = string
  default = "P365D"
}

variable "issuer_certificate_authority_id" {
  description = "The OCID of the issuer CA, required for SUBORDINATE_CA_ISSUED_BY_INTERNAL_CA type."
  type = string
  default = ""
}