# This data source fetches the project name, and provides the appropriate URLs to use for container registry for this project.
# https://www.terraform.io/docs/providers/google/d/google_container_registry_repository.html
data "google_container_registry_repository" "registry" {
  project                   = var.project
}

# Provides access to available Google Container Engine versions in a zone for a given project.
# https://www.terraform.io/docs/providers/google/d/google_container_engine_versions.html
data "google_container_engine_versions" "engine_version" {
  project                   = var.project
  location                  = var.zone
}

# Query my Terraform service account from GCP
data "google_client_config" "current" {}
resource "google_container_cluster" "primary" {
  provider                  = google-beta
  name                      = var.name
  description               = var.description
  #zonal cluster
  location                  = var.zone
  initial_node_count        = var.initial_node_count
  remove_default_node_pool  = "true"
  project                   = var.project
  default_max_pods_per_node = var.default_max_pods_per_node
  #min_master_version        = data.google_container_engine_versions.engine_version.latest_master_version
  min_master_version          = var.min_cluster_version
  //posible destruct terraform plan with Error: Get http://localhost/version?timeout=32s: dial tcp [::1]:80: connect: connection refused
  #enable_kubernetes_alpha   = true

//  node_version              = data.google_container_engine_versions.engine_version.latest_node_version

  addons_config {
    kubernetes_dashboard {
      disabled              = var.disable_dashboard
    }

    http_load_balancing {
      disabled              = var.disable_autoscaling_addon
    }
  }

  network                   = var.network
  subnetwork                = var.subnetwork

  ip_allocation_policy {
    #use_ip_aliases          = "false"
    services_ipv4_cidr_block = var.services_network
    node_ipv4_cidr_block     = var.nodes_network
    create_subnetwork        = "false"
    cluster_ipv4_cidr_block  = var.pods_network

  }
#cluster_ipv4_cidr - The IP address range of the kubernetes pods in this cluster. Default is an automatically assigned CIDR
# cluster_ipv4_cidr = "${var.pods_network}"

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.220.0/28"
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

}
