module "organization" {
  source = "./modules/organization"
}

module "iam_groups" {
  source = "./modules/groups-n-policies"

  iam_groups = var.iam_groups
}
