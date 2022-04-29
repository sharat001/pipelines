provider "aws"{

    region = var.region
}


resource "aws_wafv2_web_acl" "example" {
  name        = var.web_acl_name
  description = "Description of my managed rule."
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = var.rule_name
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = var.rule_group_name
        vendor_name = "AWS"

        excluded_rule {
          name = "SizeRestrictions_QUERYSTRING"
        }

        excluded_rule {
          name = "NoUserAgent_HEADER"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = var.rule_metric_name
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = var.acl_metric_name
    sampled_requests_enabled   = false
  }
}
