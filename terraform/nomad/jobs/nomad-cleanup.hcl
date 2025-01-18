job "nomad-cleanup" {
  datacenters = ["dc1"]
  type        = "batch"

  periodic {
    crons            = ["@daily"]
    prohibit_overlap = true
  }

  group "garbage_collection" {
    task "garbage_collection" {
      driver = "raw_exec"

      config {
        command = "nomad"
        args    = ["system", "gc", "--address", "http://server01.bakos.lan:4646"]
      }
    }
  }
}