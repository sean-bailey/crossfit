provider "aws" {
access_key = "${var.access_key}"
secret_key = "${var.secret_key}"
region     = "${var.region}"
}

locals {
function_name = "kb4sre-exercise"
}

resource "aws_lambda_function" "test_lambda" {
  filename = "../lambda.zip"
  function_name    = "${local.function_name}"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "lambda_function.lambda_handler"

  source_code_hash = "${filebase64sha256("../lambda.zip")}"
  runtime          = "python2.7"

  memory_size = 128
  timeout = "10"
  tags {
  terraform = "true"
  app = "test"
  service = "test"
  environment = "test"
  }
}

data "template_file" "lambda_assume_policy" {
template = "${file("./files/assume-policy.json")}"
}

data "template_file" "lambda_task_policy" {
template = "${file("./files/task-policy.json")}"
}

resource "aws_iam_policy" "task-policy" {
name = "${local.function_name}-policy"
description = "Task Policy"
policy = "${data.template_file.lambda_task_policy.rendered}"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "${local.function_name}-lambda-role"

  assume_role_policy = "${data.template_file.lambda_assume_policy.rendered}"
  depends_on = [
  "aws_iam_policy.task-policy",
  ]
}

resource "aws_iam_policy_attachment" "main-attach" {
name = "test-attachment"
users = []
roles = ["${aws_iam_role.iam_for_lambda.name}"]
groups = []
policy_arn = "${aws_iam_policy.task-policy.arn}"
}
