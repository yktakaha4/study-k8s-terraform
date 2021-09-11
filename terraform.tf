# S3バックエンドを利用する場合、コメントアウトを解除する
# バケットは事前に作成しておく必要あり
# terraform {
#   backend "s3" {
#     bucket = "YOUR_BUCKET_NAME"
#     key    = "study-k8s/terraform.tfstate"
#     region = "ap-northeast-1"
#   }
# }
