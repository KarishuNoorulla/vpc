resource "google_compute_instance" "app_vm" {
  name         = var.vm_name
  machine_type = "n1-standard-1"
  zone         = var.zone
  tags         = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = templatefile("${path.module}/startup-script.sh", {
    app_port = 8080
  })
}

resource "google_compute_firewall" "http" {
  name    = "allow-http-${var.vm_name}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

# Startup script file (modules/vm/startup-script.sh)