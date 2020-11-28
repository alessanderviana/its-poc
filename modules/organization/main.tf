resource "aws_organizations_organization" "poc_org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set = "ALL"
  # enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
}

/* ############### Organizational Unit ############### */

resource "aws_organizations_organizational_unit" "poc_ou" {
  name      = "poc-ou"
  parent_id = aws_organizations_organization.poc_org.roots[0].id
}

/* ############### Organization Accounts ############### */

resource "aws_organizations_account" "developer_account" {
  name  = "developer-account"
  email = "developer-account@its.org"

  # Parent Organizational Unit ID
  # Defaults to the Organization default Root ID
  parent_id = aws_organizations_organizational_unit.poc_ou.id

  role_name = "developerOrganizationRole"
  # There is no AWS Organizations API for reading role_name
  lifecycle {
    ignore_changes = [role_name]
  }

}

resource "aws_organizations_account" "tests_account" {
  name  = "tests-account"
  email = "developer-account@its.org"

  parent_id = aws_organizations_organizational_unit.poc_ou.id

  role_name = "testsOrganizationRole"
  lifecycle {
    ignore_changes = [role_name]
  }

}

resource "aws_organizations_account" "acceptance_account" {
  name  = "acceptance-account"
  email = "acceptance-account@its.org"

  parent_id = aws_organizations_organizational_unit.poc_ou.id

  role_name = "acceptanceOrganizationRole"
  lifecycle {
    ignore_changes = [role_name]
  }

}

resource "aws_organizations_account" "production_account" {
  name  = "production-account"
  email = "production-account@its.org"

  parent_id = aws_organizations_organizational_unit.poc_ou.id

  role_name = "productionOrganizationRole"
  lifecycle {
    ignore_changes = [role_name]
  }

}

resource "aws_organizations_account" "management_account" {
  name  = "management-account"
  email = "management-account@its.org"

  role_name = "managementOrganizationRole"
  lifecycle {
    ignore_changes = [role_name]
  }

}

resource "aws_organizations_account" "shared_services_account" {
  name  = "shared-services-account"
  email = "shared-services-account@its.org"

  role_name = "shared-servicesOrganizationRole"
  lifecycle {
    ignore_changes = [role_name]
  }

}
