// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

variable "domain_name" {
  description = "The primary FQDN for the certificate."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9.-]+[a-zA-Z0-9]$", var.domain_name))
    error_message = "The domain_name must be a valid FQDN."
  }
}

variable "route53_zone_id" {
  description = "The Route53 zone ID where the certificate will be validated."
  type        = string
  default     = ""
  validation {
    condition     = can(regex("^[A-Z0-9]{10,}$", var.route53_zone_id)) || var.route53_zone_id == ""
    error_message = "The route53_zone_id must be a valid Route53 zone ID or empty."
  }
}

variable "key_algorithm" {
  description = "The key algorithm to use for the certificate. Default is 'RSA_2048'."
  type        = string
  default     = "RSA_2048"
  validation {
    condition     = contains(["RSA_2048", "EC_prime256v1", "EC_secp384r1", "EC_secp521r1"], var.key_algorithm)
    error_message = "Key algorithm must be one of 'RSA_2048', 'EC_prime256v1', 'EC_secp384r1', or 'EC_secp521r1'."
  }
}

variable "validation_method" {
  description = "The validation method for the certificate. Default is 'DNS'."
  type        = string
  default     = "DNS"
  validation {
    condition     = var.validation_method == "DNS" || var.validation_method == "EMAIL"
    error_message = "Validation method must be either 'DNS' or 'EMAIL'."
  }
}

variable "subject_alternative_names" {
  description = "A list of subject alternative names for the certificate."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
