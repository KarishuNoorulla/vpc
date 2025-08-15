# Install Anthos components after cluster creation
resource "null_resource" "install_anthos" {
  depends_on = [module.anthos_cluster]

  provisioner "local-exec" {
    command = <<-EOT
      gcloud services enable \
        anthos.googleapis.com \
        gkehub.googleapis.com \
        cloudresourcemanager.googleapis.com
      
      gcloud container hub memberships register ${module.anthos_cluster.cluster_name} \
        --gke-cluster ${var.zone}/${module.anthos_cluster.cluster_name} \
        --enable-workload-identity
    EOT
  }
}