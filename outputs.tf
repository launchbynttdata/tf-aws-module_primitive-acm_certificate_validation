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

output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate_validation.cert_validation.certificate_arn
}

output "validation_records" {
  description = "List of validation records for the ACM certificate"
  value       = aws_acm_certificate_validation.cert_validation.validation_record_fqdns
}

output "id" {
  description = "ID of the ACM certificate validation"
  value       = aws_acm_certificate_validation.cert_validation.id
}
