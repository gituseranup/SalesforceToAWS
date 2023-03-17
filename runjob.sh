# !/bin/bash
cd live



sed -i '/val soql =/d' filesToUpload/SfdcExtractData.scala
sed -i '/val savePath =/d' filesToUpload/SfdcExtractData.scala

echo Please provide Qwery for fetching the data from salesforce.
read newQWERY
sed -i "14 a\    val soql = \"${newQWERY}\"   " filesToUpload/SfdcExtractData.scala
datePath=$(date +'%Y/%m/%d')
sed -i "17 a\    val savePath = \"s3://${Bucket_name}/output/${datePath}/\"   " filesToUpload/SfdcExtractData.scala


aws s3 cp filesToUpload/SfdcExtractData.scala s3://${Bucket_name}/files/

aws glue start-job-run  --job-name ${GLUE_JOB_NAME}
echo your job is ready !!!

sed -i '/val soql =/d' filesToUpload/SfdcExtractData.scala