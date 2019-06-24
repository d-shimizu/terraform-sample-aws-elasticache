resource "aws_security_group" "this" {
  // name_prefix = "${var.namespace}"
  name_prefix = "cahce-default-tf-sg-example"
  //vpc_id      = "${aws_vpc.default.id}"
  vpc_id	= "${var.default_vpc}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_elasticache_cluster" "this" {
  cluster_id           = "cluster-example-tf"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
  engine_version       = "5.0.4"
  port                 = 6379
  subnet_group_name    = "default"
  // security_group_ids   = "${aws_security_group.this.id}"
  security_group_ids   = ["${aws_security_group.this.id}"]
}
