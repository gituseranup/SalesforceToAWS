#!/usr/bin
echo we are checking if aws cli is installed or not  !!!
sh ./aws-configure.sh
cd live
DIR=./var_input
if [ -d "$DIR" ]; then
  rm -rf var_input
fi
mkdir var_input

chmod -R 777 var_input

touch var_input/skpi.tfvars

echo !!! Now we are starting creating Infrastructure using Terraform !!!
echo Please provide AWS Region
read AWS_REGION
echo AWS_REGION="\"$AWS_REGION\"" >> var_input/skpi.tfvars

echo Please provide Role name which will used for the Glue-Job.
read glue_role_name
echo glue_role_name="\"$glue_role_name\"" >> var_input/skpi.tfvars

echo Please provide GLUE_JOB_NAME for fetching the data from salesforce.
read GLUE_JOB_NAME
echo GLUE_JOB_NAME="\"$GLUE_JOB_NAME\"" >> var_input/skpi.tfvars
sed -i "2 a\GLUE_JOB_NAME=${GLUE_JOB_NAME}   " ../runjob.sh

sed -i '/val soql =/d' filesToUpload/SfdcExtractData.scala
echo Please provide Query for fetching the data from salesforce.
read QWERY
sed -i "14 a\    val soql = \"${QWERY}\"   " filesToUpload/SfdcExtractData.scala

echo Please provide User-Id for salesforce login.
read Salesforce_Login_Id
sed -i "15 a\    val salesforceUsername = \"${Salesforce_Login_Id}\"   " filesToUpload/SfdcExtractData.scala

echo Please provide Password+Token for salesforce login.
read Salesforce_Password
sed -i "16 a\    val salesforcePassword = \"${Salesforce_Password}\"   " filesToUpload/SfdcExtractData.scala

echo Enter trigger name which will run daily.
read trigger_name
echo trigger_name="\"$trigger_name\"" >> var_input/skpi.tfvars

echo Please provide the time at which, Daily you want to run job automatically.
echo Enter HOUR  24 hour format "( 00 - 24 )".
read cron_hour
echo cron_hour="\"$cron_hour\"" >> var_input/skpi.tfvars

echo Enter MINUTE  24 hour format "( 00 - 59 )".
read cron_minute
echo cron_minute="\"$cron_minute\"" >> var_input/skpi.tfvars

echo Please provide bucket name  in which your data will be saved !!!
echo Please use only Small letters a-z, numbers 0-9, and hyphen "(-)" only.
read Bucket_name
echo Bucket_name="\"$Bucket_name\"" >> var_input/skpi.tfvars
sed -i "3 a\Bucket_name=${Bucket_name}   " ../runjob.sh
datePath=$(date +'%Y/%m/%d')
sed -i "17 a\    val savePath = \"s3://${Bucket_name}/output/${datePath}/\"   " filesToUpload/SfdcExtractData.scala


sed -i '' -e '$a\' var_input/skpi.tfvars

terraform init
terraform plan -var-file var_input/skpi.tfvars
terraform apply -var-file var_input/skpi.tfvars

aws glue start-job-run  --job-name ${GLUE_JOB_NAME}

echo  Thank You !! for your patience your Glue-ETL Job is now ready !
sed -i '/val soql =/d' filesToUpload/SfdcExtractData.scala