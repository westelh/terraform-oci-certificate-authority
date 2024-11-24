resource "oci_certificates_management_certificate_authority" "ca" {
    compartment_id = var.compartment_id
    kms_key_id = oci_kms_key.encryption_key.id
    description = var.description
    name = var.name

    certificate_authority_config {
        config_type = var.type
        signing_algorithm = var.signing_algorithm
        issuer_certificate_authority_id = var.issuer_certificate_authority_id

        subject {
            common_name = var.common_name
            distinguished_name_qualifier = var.distinguished_name_qualifier
        }
    }

    certificate_authority_rules {
        certificate_authority_max_validity_duration = var.ca_max_validity
        leaf_certificate_max_validity_duration = var.leaf_max_validity
        rule_type = "CERTIFICATE_AUTHORITY_ISSUANCE_EXPIRY_RULE"
    }

    certificate_revocation_list_details {
        object_storage_config {
            object_storage_bucket_name = oci_objectstorage_bucket.crl_bucket.name
            object_storage_namespace = data.oci_objectstorage_namespace.compartment_unique.namespace
            object_storage_object_name_format = "IssuedCRLByCAVersion{}.crl"
        }
    } 

    freeform_tags = {
        "CreatedBy" = "Terraform"
        "Module" = "authority"
        "CA" = var.name
    }
}