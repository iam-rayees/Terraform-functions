resource "aws_lb" "external-alb" {
  name               = "${var.environment}-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_all.id]
  subnets            = aws_subnet.public_subnets[*].id
  tags = {
    Name       = "${var.environment}-ALB"
    Owner      = local.Owner
    TeamDL     = local.TeamDL
    costcenter = local.costcenter

  }

}

resource "aws_lb_target_group" "target_alb" {
  name     = "ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Vpc_Terra.id
  health_check {
    path     = "/"
    port     = 80
    protocol = "HTTP"
  }
}

resource "aws_alb_target_group_attachment" "target_alb_attach" {
  count            = length(local.all_instance_ids)
  target_group_arn = aws_lb_target_group.target_alb.arn
  target_id        = local.all_instance_ids[count.index]
  port             = 80
  depends_on       = [aws_lb_target_group.target_alb]

}

resource "aws_lb_listener" "listener_alb_http" {
  load_balancer_arn = aws_lb.external-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

data "aws_acm_certificate" "issued" {
  domain      = "*.cloudrayeez.xyz"
  statuses    = ["ISSUED"]
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

resource "aws_lb_listener" "listener_alb_https" {
  load_balancer_arn = aws_lb.external-alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.issued.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_alb.arn
  }
}

data "aws_route53_zone" "cloudrayeez" {
  name = "cloudrayeez.xyz"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.cloudrayeez.zone_id
  name    = "www.cloudrayeez.xyz"
  type    = "A"

  alias {
    name                   = aws_lb.external-alb.dns_name
    zone_id                = aws_lb.external-alb.zone_id
    evaluate_target_health = true
  }
}
