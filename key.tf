resource "oci_kms_key" "encryption_key" {
    compartment_id = var.compartment_id
    management_endpoint = var.key_management_endpoint
    display_name = "CA Encryption Key - ${var.name}"
    desired_state = "ENABLED"
    key_shape {
        algorithm = "ECDSA"
        curve_id = "NIST_P384"
        length = 48
    }
    freeform_tags = {
        "CreatedBy" = "Terraform",
        "Module" = "authority"
        "CA" = var.name
    }
}
