domain_name               = "terratest.sandbox.launch.nttdata.com"
subject_alternative_names = ["www.terratest.sandbox.launch.nttdata.com"]
validation_method         = "DNS"
key_algorithm             = "EC_prime256v1"
route53_zone_id           = "Z0784995304VEG2Z7RSRF" # sandbox.launch.nttdata.com
tags = {
  "environment" = "terratest"
}
