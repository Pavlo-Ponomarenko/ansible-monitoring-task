module "vpc" {
  source = "./modules/vpc"
}

module "keys" {
   source = "./modules/keys"
}

module "control_node" {
  source = "./modules/control_node"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  key_name = module.keys.key_name
}


module "target_node" {
  source = "./modules/target_node"
  vpc_id = module.vpc.vpc_id
  control_node_sg_id = module.control_node.control_node_sg_id
  private_subnet_id = module.vpc.private_subnet_id
  key_name = module.keys.key_name
}
