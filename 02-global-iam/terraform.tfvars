
# This is an example of global IAM configuration. Use this to give users, groups, and service accounts access to folders,
# projects, etc.

#org_bindings = {
#  "roles/billing.viewer" = [
#    "user:operator-one@markodevops.com",
#  ]
#  "roles/resourcemanager.folderViewer" = [
#    "user:operator-one@markodevops.com",
#  ]
#}
#
#folders_iam = {
#  # Bindings for the acme-dev folder
#  "dev" = {
#    bindings = {
#      "roles/browser" = [
#        "user:operator-one@markodevops.com",
#      ]
#    }
#    conditional_bindings = []
#  }
#  # binding for the acme-stg folder
#  "stg" = {
#    bindings = {
#      "roles/browser" = [
#        "user:operator-one@markodevops.com",
#      ]
#    }
#    conditional_bindings = []
#  }
#  # Bindings to the acme-prd folder
#  "prd" = {
#    bindings = {
#      "roles/browser" = [
#        "user:operator-one@markodevops.com",
#      ]
#    }
#    conditional_bindings = []
#  }
#  # Bindings for the acme-shared folder
#  "shared" = {
#    bindings = {
#      "roles/browser" = [
#        "user:operator-one@markodevops.com",
#      ]
#    }
#    conditional_bindings = []
#  }
#}
#
#audit_bindings = {
#  "roles/viewer" = [
#    "user:operator-one@markodevops.com",
#  ]
#}
#
#billing_project_bindings = {
#  "roles/viewer" = [
#    "user:operator-one@markodevops.com",
#  ]
#}