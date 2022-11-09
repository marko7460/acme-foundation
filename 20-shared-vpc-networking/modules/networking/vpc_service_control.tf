# Set VPC service controls
locals {
  supported_restricted_service = [
    "accessapproval.googleapis.com",
    "adsdatahub.googleapis.com",
    "aiplatform.googleapis.com",
    "alloydb.googleapis.com",
    "alpha-documentai.googleapis.com",
    "analyticshub.googleapis.com",
    "apigee.googleapis.com",
    "apigeeconnect.googleapis.com",
    "artifactregistry.googleapis.com",
    "assuredworkloads.googleapis.com",
    "automl.googleapis.com",
    "baremetalsolution.googleapis.com",
    "batch.googleapis.com",
    "bigquery.googleapis.com",
    "bigquerydatapolicy.googleapis.com",
    "bigquerydatatransfer.googleapis.com",
    "bigquerymigration.googleapis.com",
    "bigqueryreservation.googleapis.com",
    "bigtable.googleapis.com",
    "binaryauthorization.googleapis.com",
    "cloud.googleapis.com",
    "cloudasset.googleapis.com",
    "cloudbuild.googleapis.com",
    "clouddebugger.googleapis.com",
    "clouddeploy.googleapis.com",
    "clouderrorreporting.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudprofiler.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudscheduler.googleapis.com",
    "cloudsearch.googleapis.com",
    "cloudtrace.googleapis.com",
    "composer.googleapis.com",
    "compute.googleapis.com",
    "connectgateway.googleapis.com",
    "contactcenterinsights.googleapis.com",
    "container.googleapis.com",
    "containeranalysis.googleapis.com",
    "containerfilesystem.googleapis.com",
    "containerregistry.googleapis.com",
    "containerthreatdetection.googleapis.com",
    "datacatalog.googleapis.com",
    "dataflow.googleapis.com",
    "datafusion.googleapis.com",
    "datamigration.googleapis.com",
    "dataplex.googleapis.com",
    "dataproc.googleapis.com",
    "datastream.googleapis.com",
    "dialogflow.googleapis.com",
    "dlp.googleapis.com",
    "dns.googleapis.com",
    "documentai.googleapis.com",
    "domains.googleapis.com",
    "eventarc.googleapis.com",
    "file.googleapis.com",
    "firebaseappcheck.googleapis.com",
    "firebaserules.googleapis.com",
    "firestore.googleapis.com",
    "gameservices.googleapis.com",
    "gkebackup.googleapis.com",
    "gkeconnect.googleapis.com",
    "gkehub.googleapis.com",
    "healthcare.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "iaptunnel.googleapis.com",
    "ids.googleapis.com",
    "integrations.googleapis.com",
    "kmsinventory.googleapis.com",
    "krmapihosting.googleapis.com",
    "language.googleapis.com",
    "lifesciences.googleapis.com",
    "logging.googleapis.com",
    "managedidentities.googleapis.com",
    "memcache.googleapis.com",
    "meshca.googleapis.com",
    "meshconfig.googleapis.com",
    "metastore.googleapis.com",
    "ml.googleapis.com",
    "monitoring.googleapis.com",
    "networkconnectivity.googleapis.com",
    "networkmanagement.googleapis.com",
    "networksecurity.googleapis.com",
    "networkservices.googleapis.com",
    "notebooks.googleapis.com",
    "opsconfigmonitoring.googleapis.com",
    "orgpolicy.googleapis.com",
    "osconfig.googleapis.com",
    "oslogin.googleapis.com",
    "privateca.googleapis.com",
    "pubsub.googleapis.com",
    "pubsublite.googleapis.com",
    "recaptchaenterprise.googleapis.com",
    "recommender.googleapis.com",
    "redis.googleapis.com",
    "retail.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "servicecontrol.googleapis.com",
    "servicedirectory.googleapis.com",
    "spanner.googleapis.com",
    "speakerid.googleapis.com",
    "speech.googleapis.com",
    "sqladmin.googleapis.com",
    "storage.googleapis.com",
    "storagetransfer.googleapis.com",
    "sts.googleapis.com",
    "texttospeech.googleapis.com",
    "timeseriesinsights.googleapis.com",
    "tpu.googleapis.com",
    "trafficdirector.googleapis.com",
    "transcoder.googleapis.com",
    "translate.googleapis.com",
    "videointelligence.googleapis.com",
    "vision.googleapis.com",
    "visionai.googleapis.com",
    "vmmigration.googleapis.com",
    "vpcaccess.googleapis.com",
    "webrisk.googleapis.com",
    "workflows.googleapis.com",
    "workstations.googleapis.com",
  ]

}

module "access_level_members" {
  for_each = { for k, v in var.shared_vpcs : k => v if v.access_context_manager_policy_name != null }
  source   = "terraform-google-modules/vpc-service-controls/google//modules/access_level"
  version  = "~> 4.0"

  description = "${module.vpc[each.key].project_id}-${each.key} Access Level"
  policy      = data.tfe_outputs.org-policies.values.access_context_manager_policy_ids[each.value.access_context_manager_policy_name]
  name        = "alp_${random_string.main[each.key].result}_members"
  members     = each.value.vpc_access_members
}

resource "random_string" "main" {
  for_each = { for k, v in var.shared_vpcs : k => v if v.access_context_manager_policy_name != null }
  length   = 6
  special  = false
  lower    = true
  upper    = false
  numeric  = true
}

resource "time_sleep" "wait_vpc_sc_propagation" {
  create_duration  = "60s"
  destroy_duration = "60s"

  depends_on = [
    module.vpc,
    module.private_service_connect,
    module.peering_zone,
    module.peering_zone,
    google_compute_global_address.private_service_access_address,
    google_service_networking_connection.private_vpc_connection,
    google_dns_policy.default_policy,
    google_compute_firewall.deny_all_egress,
    google_compute_firewall.allow_private_api_egress,
    google_compute_firewall.allow_all_egress,
    google_compute_firewall.allow_all_ingress,
    google_compute_router.router,
    google_compute_router_nat.nats,
  ]
}

module "regular_service_perimeter" {
  for_each = { for k, v in var.shared_vpcs : k => v if v.access_context_manager_policy_name != null }
  source   = "terraform-google-modules/vpc-service-controls/google//modules/regular_service_perimeter"
  version  = "~> 4.0"

  policy         = data.tfe_outputs.org-policies.values.access_context_manager_policy_ids[each.value.access_context_manager_policy_name]
  perimeter_name = "sp_${random_string.main[each.key].result}_default_perimeter"
  description    = "${module.vpc[each.key].project_id}-${each.key} VPC Service Controls perimeter"
  resources      = [nonsensitive(data.tfe_outputs.host_project.values.projects[each.value.host_project].project_number)]
  access_levels  = [module.access_level_members[each.key].name]

  restricted_services     = length(each.value.restricted_services) != 0 ? each.value.restricted_services : local.supported_restricted_service
  vpc_accessible_services = ["RESTRICTED-SERVICES"]

  ingress_policies = each.value.ingress_policies
  egress_policies  = each.value.egress_policies

  depends_on = [
    time_sleep.wait_vpc_sc_propagation
  ]
}