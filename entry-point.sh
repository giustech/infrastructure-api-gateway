echo "Start Terraform provider!"

rm -rf /terraform-exec
mkdir -p /terraform-exec
cp -rp /files/terraform/* /terraform-exec
cd /terraform-exec

RUN aws configure set aws_access_key_id $AWS_ACCESS_KEY
RUN aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
RUN aws configure set default.region $AWS_REGION

export TF_VAR_access_key=$AWS_ACCESS_KEY_ID
export TF_VAR_secret_key=$AWS_SECRET_ACCESS_KEY
export TF_VAR_region=$AWS_REGION

cat ~/.aws/credentials

echo "+---------------------------------------------------------+"
echo "|   ________.__                __                .__      |"
echo "|  /  _____/|__|__ __  _______/  |_  ____   ____ |  |__   |"
echo "| /   \  ___|  |  |  \/  ___/\   __\/ __ \_/ ___\|  |  \  |"
echo "| \    \_\  \  |  |  /\___ \  |  | \  ___/\  \___|   Y  \ |"
echo "|  \______  /__|____//____  > |__|  \___  >\___  >___|  / |"
echo "|         \/              \/            \/     \/     \/  |"
echo "+---------------------------------------------------------+"

echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
echo "TERRAFORM_BUCKET: $TERRAFORM_BUCKET"
echo "TERRAFORM_KEY: $TERRAFORM_KEY"
echo "TERRAFORM_BUCKET_REGION: $TERRAFORM_BUCKET_REGION"
echo "REGION: $AWS_REGION"
terraform init -backend-config="bucket=$TERRAFORM_BUCKET" -backend-config="key=$TERRAFORM_KEY" -backend-config="region=$TERRAFORM_BUCKET_REGION"
terraform plan
terraform apply -auto-approve
#terraform destroy -auto-approve