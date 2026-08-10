module "vpc" {
  source = "./modules/vpc"
}

module "keys" {
   source = "./modules/keys"
}

module "target_node" {
  source = "./modules/target_node"
  private_subnet_id = module.vpc.private_subnet_id
  key_name = module.keys.key_name
}

module "control_node" {
  source = "./modules/control_node"
  public_subnet_id = module.vpc.public_subnet_id
  key_name = module.keys.key_name
}

