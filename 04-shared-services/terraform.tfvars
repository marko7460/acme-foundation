terraform_service_account = "tf-project-creator-shared"
projects = {
  common-services = {
    labels = {
      environment       = "shared"
      application_name  = "common-services"
      billing_code      = "0001"
      primary_contact   = "example1"
      secondary_contact = "example2"
      business_code     = "share"
      env_code          = "01"
    }
    vpcs = {
      dns-hub = {
        subnets = [{
          subnet_name           = "dnshub-region1"
          subnet_ip             = "172.16.0.0/25"
          subnet_region         = "us-west1"
          subnet_private_access = "true"
          subnet_flow_logs      = false
          description           = "DNS hub subnet for region 1."
          }, {
          subnet_name           = "dnshub-region2"
          subnet_ip             = "172.16.0.128/25"
          subnet_region         = "us-central1"
          subnet_private_access = "true"
          subnet_flow_logs      = false
          description           = "DNS hub subnet for region 2."
        }]
      }
    }
  }
}

private_dns = {
  dev = {
    domain  = "dev.acme.private."
    vpc     = "dns-hub"
    project = "common-services"
  }
  restricted-dev = {
    domain  = "restricted-dev.acme.private."
    vpc     = "dns-hub"
    project = "common-services"
  }
  stg = {
    domain  = "stg.acme.private."
    vpc     = "dns-hub"
    project = "common-services"
  }
  restricted-stg = {
    domain  = "restricted-stg.acme.private."
    vpc     = "dns-hub"
    project = "common-services"
  }
  prd = {
    domain  = "prd.acme.private."
    vpc     = "dns-hub"
    project = "common-services"
  }
  restricted-prd = {
    domain  = "restricted-prd.acme.private."
    vpc     = "dns-hub"
    project = "common-services"
  }
}