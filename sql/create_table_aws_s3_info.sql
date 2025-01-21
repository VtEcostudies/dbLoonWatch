create table aws_s3_info (
	"bucketName" text, 
	"region" text,
	"accessKeyId" text,
	"secretAccessKey" text
);

insert into aws_s3_info(
	"bucketName", "region", "accessKeyId", "secretAccessKey"
) VALUES (
	'loonwatch.photos', 'us-west-2', '', ''
);