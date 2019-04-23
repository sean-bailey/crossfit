locals {
function_name = "kb4sre-exercise"
}

resource "aws_lambda_function" "main" {

function_name = "${local.function_name}"

role = "${aws_iam_role.main.arn}"

handler = "lambda_function.lambda_handler"

runtime = "python2.7"

source_code_hash = "${base64sha256(file(./lambda.zip))}"

filename = "./lambda.zip"

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

resource "aws_iam_role" "main" {
name = "${local.function_name}-lambda"
description = "IAM role for ${local.function_name}"
assume_role_policy = "${data.template_file.lambda_assume_policy.rendered}"
depends_on = [
"aws_iam_policy.task-policy",
]
}

resource "aws_iam_policy" "task-policy" {
name = "${local.function_name}-lambda-task"
description = "Task Policy"
policy = "${data.template_file.lambda_task_policy.rendered}"
}

resource "aws_iam_policy_attachment" "main-attach" {
name = "test-attachment"
users = []
roles = ["${aws_iam_role.main.name}"]
groups = []
policy_arn = "${aws_iam_policy.task-policy.arn}"
}
