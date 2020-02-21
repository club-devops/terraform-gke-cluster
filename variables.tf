
variable "name" {
  description = "The name of the cluster, unique within the project and zone"
  default     = "primary"
}

variable "project" {
  description = "project ID"
}

variable "description" {
  description = "Cluster description"
}

variable "zone" {
  description = "The zone the master and nodes specified in initial_node_count should be created in"
}

variable "min_cluster_version" {}
variable "disable_dashboard" {
  description = "Whether the Kubernetes Dashboard should be disabled"
  default     = false
}

variable "disable_autoscaling_addon" {
  description = "Whetherthe Autoscaling Pod addon should be disabled"
  default     = false
}

variable "initial_node_count" {
  description = "The number of nodes to create in this cluster (not including the Kubernetes master)"
  default     = 1
}

variable "network" {
  description = "The name or self_link of the Google Compute Engine network to which the cluster is connected"
  default     = "default"
}

variable "subnetwork" {
  description = "The name of the Google Compute Engine network subnetwork"
  default     = "cluster-subnetwork"

}

variable "nodes_network" {
  description = "Nodes network"
  default = "10.50.25.0/24"
}

variable "pods_network" {
  description = "Pods network"
  default = "10.50.128.0/18"
}

variable "services_network" {
  description = "Services network"
  default = "10.50.192.0/18"

}

variable "node_disk_size_gb" {
  description = "Size of the disk attached to each node, specified in GB"
  default     = 10
}

variable "node_machine_type" {
  description = "The name of a Google Compute Engine machine type"
  default     = "n1-standard-1"
}

variable "default_max_pods_per_node" {
  description = "Max pods per node"
  default = 32
}
