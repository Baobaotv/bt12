terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

locals {
  name = "baonx"
}

##############
# Networking
##############
module "networking" {
  source = "./modules/networking"

  name = local.name
}

##############
# Database
##############
module "database" {
  source = "./modules/database"

  name                  = local.name
  vpc_id                = module.networking.vpc_id
  vpc_public_subnet_ids = module.networking.public_subnet_ids
  vpc_sg                = module.networking.sg
}

##############
# Webserver
##############
module "web" {
  source = "./modules/webserver"

  name   = local.name
  vpc_id = module.networking.vpc_id
  vpc_sg = module.networking.sg
}

##############
# Webfe
##############
module "webfe" {
  source = "./modules/webfe"
}




