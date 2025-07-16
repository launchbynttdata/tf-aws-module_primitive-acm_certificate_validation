# module "aws_acm_certificate" {
#   # source                    = "../.."
#   source  = "terraform.registry.launch.nttdata.com/module_primitive/aws_acm_certificate"
#   version = "~> 1.0"
#   domain_name               = var.domain_name
#   subject_alternative_names = var.subject_alternative_names
#   validation_method         = var.validation_method
#   key_algorithm             = var.key_algorithm
#   options                   = var.options
#   validation_option         = var.validation_option
#   tags                      = var.tags
# }

resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  validation_method         = var.validation_method
  subject_alternative_names = var.subject_alternative_names
  key_algorithm             = var.key_algorithm
  tags = merge(
    {
      name = join("-", [var.domain_name, "acm-cert"])
    },
    var.tags
  )
  lifecycle {
    create_before_destroy = true
  }
}

module "cert_validation" {
  source = "../.."
  # certificate_arn = module.aws_acm_certificate.certificate_arn
  certificate_arn    = aws_acm_certificate.cert.arn
  validation_records = keys(module.cert_validation_records.record_fqdns)
}

# resource "aws_acm_certificate_validation" "cert_validation" {
#   certificate_arn         = module.aws_acm_certificate.certificate_arn
#   validation_record_fqdns = keys(module.cert_validation_records.record_fqdns)
# }

module "cert_validation_records" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/dns_record/aws"
  version = "~> 1.0"
  zone_id = data.aws_route53_zone.sandbox.zone_id
  records = {
    # for dvo in module.aws_acm_certificate.domain_validation_options : dvo.domain_name => {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name            = dvo.resource_record_name
      records         = [dvo.resource_record_value]
      type            = dvo.resource_record_type
      ttl             = 60
      allow_overwrite = true
      zone_id         = data.aws_route53_zone.sandbox.zone_id
    }
  }
}
