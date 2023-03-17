#!/usr/bin
cd live
# echo these are the services created !!!
# terraform state list

echo The bucket Will Not be deleted for now, because of Data,
echo if you want to delete the BUCKET then delete by yourself !!!

terraform state rm aws_s3_bucket.salesforce-aws-data-bucket
terraform state rm aws_s3_bucket_acl.salesforce-aws-data-bucket
terraform state rm aws_s3_bucket_versioning.versioning_enable
terraform state rm aws_s3_object.output-folder

echo Removed bucket from deletion list,
echo Now we are destroying whole Infrastructure except your data !!!

terraform destroy -var-file var_input/skpi.tfvars

sed -i '/val soql =/d' filesToUpload/SfdcExtractData.scala
sed -i '/val salesforcePassword =/d' filesToUpload/SfdcExtractData.scala
sed -i '/val salesforceUsername =/d' filesToUpload/SfdcExtractData.scala
sed -i '/val savePath =/d' filesToUpload/SfdcExtractData.scala

DIR=./var_input
if [ -d "$DIR" ]; then
  rm -rf var_input
fi

cd ..
sed -i '/GLUE_JOB_NAME=/d' runjob.sh
sed -i '/Bucket_name=/d' runjob.sh