aws_account_id=$(aws --profile devops sts get-caller-identity --query 'Account' --output text)

# Docker login
aws --profile devops --region ap-northeast-1 ecr get-login-password | docker login --username AWS --password-stdin 047980477351.dkr.ecr.ap-northeast-1.amazonaws.com

# Build image
docker build -t 047980477351.dkr.ecr.ap-northeast-1.amazonaws.com/fluentbit:latest .

# Push image
docker push 047980477351.dkr.ecr.ap-northeast-1.amazonaws.com/fluentbit:latest
