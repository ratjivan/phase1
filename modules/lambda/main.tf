data "archive_file" "lambda_zip" {

  type = "zip"

  source_dir = var.lambda_source

  output_path = "${path.module}/${var.function_name}.zip"

}