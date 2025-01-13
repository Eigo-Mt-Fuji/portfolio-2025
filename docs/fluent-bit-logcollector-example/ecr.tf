resource "aws_ecr_repository" "fluentbit" {
  name                 = "${var.env}-fluentbit"
  image_tag_mutability = "MUTABLE"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = false
  }
}
resource "null_resource" "default" {
  triggers = {
    file_content_sha1 = sha1(join("", [for f in ["templates/fluentbit/build.sh", "templates/fluentbit/Dockerfile"]: filesha1(f)]))
  }

  provisioner "local-exec" {
    # docker build & push
    command = "cd templates/fluentbit && sh ./build.sh"
  }
  depends_on = [aws_ecr_repository.fluentbit]
}
