data "oci_objectstorage_namespace" "compartment_unique" {
    compartment_id = var.compartment_id
}

resource "oci_objectstorage_bucket" "crl_bucket" {
    compartment_id = var.compartment_id
    name = "ca-crl-bucket-${var.name}"
    namespace = data.oci_objectstorage_namespace.compartment_unique.namespace

    access_type = "ObjectRead"

    freeform_tags = {
        "CreatedBy" = "Terraform",
        "Module" = "authority"
        "CA" = var.name
    }
}