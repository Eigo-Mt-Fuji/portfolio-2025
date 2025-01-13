resource "aws_lb" "nlb" {
  name               = "${var.env}-logcollector-nlb"
  internal           = true
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id = var.nlb_subnet[0]
  }
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 10224
  protocol          = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg.arn
  }
}

resource "aws_lb_target_group" "nlb_tg" {
  name     = "${var.env}-logcollector-tg"
  port     = 10224
  protocol = "TCP"
  vpc_id   = var.vpc_id
#  target_type = "ip"
}
