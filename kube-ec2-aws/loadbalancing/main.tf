# ---- loadbalancing/main.tf ----

resource "aws_lb" "application-loadbalacer" {
  name            = var.lb_name
  subnets         = var.lb_public_subnets
  security_groups = var.lb_security_groups
  idle_timeout    = 400
}

resource "aws_lb_target_group" "application_tg" {
  name     = "kube-${substr(uuid(), 0, 3)}"
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.tg_vpc_id
  health_check {
    healthy_threshold   = var.tg_healthy_threshold
    unhealthy_threshold = var.tg_unhealthy_threshold
    timeout             = var.tg_timeout
    interval            = var.tg_interval
  }
}

resource "aws_lb_listener" "kube-listener" {
  load_balancer_arn = aws_lb.application-loadbalacer.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application_tg.arn
  }
}