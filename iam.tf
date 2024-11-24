resource "oci_identity_dynamic_group" "group" {
  compartment_id = var.compartment_id
  name = "CAGroup-${var.name}"
  description = "Resources of CA ${var.name} belong to this group"
  matching_rule = "ALL {resource.type='certificateauthority', resource.id=${oci_certificates_management_certificate_authority.ca.id}}" 
  freeform_tags = {
    "CreatedBy" = "Terraform"
    "Module" = "authority"
    "CA" = var.name
  }
}

# Policy uses compartment name instead of OCID
data "oci_identity_compartment" "compartment" {
    id = var.compartment_id
}

resource "oci_identity_policy" "policy" {
  compartment_id = var.compartment_id
  name = "CAPolicy-${var.name}"
  description = "Allows CA ${var.name} to use releted resources"
  statements = [
    # Allow CA to use KMS key
    "Allow dynamic-group ${oci_identity_dynamic_group.group.name} to use key in tenancy where target.key.id = '${oci_kms_key.encryption_key.id}'",
    # Allow CA to use CRL bucket
    "Allow dynamic-group ${oci_identity_dynamic_group.group.name} to manage objects in tenancy where target.bucket.name='${oci_objectstorage_bucket.crl_bucket.name}'",
  ]
  freeform_tags = {
    "CreatedBy" = "Terraform"
    "Module" = "authority"
    "CA" = var.name
  }
}
