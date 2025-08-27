include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../modules/manifests"
}

locals {
  this_dir = "${get_terragrunt_dir()}"

  path_parts = split("/", local.this_dir)
  env_type = local.path_parts[length(local.path_parts) - 2]

  yaml_file_path = "${local.this_dir}/../../override.yaml.tftpl"
  version_config = yamldecode(file("${local.this_dir}/../../versions.yaml"))

  # Extract chartVersion for this environment
  chart_version = local.version_config[local.env_type]["chartVersion"]

  # Example: get the task-service image version
  task_service_image = local.version_config[local.env_type]["images"]["task-service"]

}

inputs = {
  name = "task-values-eu-west-2"
  content = templatefile(local.yaml_file_path, {
    env_type = local.env_type
    chart_version = local.chart_version
    task_service_image_tag = local.task_service_image
  })
  path = "${get_terragrunt_dir()}"
}

