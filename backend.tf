terraform {
  cloud {
    organization = "khavoks-terraform-org"
    workspaces {
      project = "Default Project"
      name = "terraform-deep-dive-course"
    }
  }
}