# inject-yaml-frontmatter.ps1 (v2 - fixed scoping)
# Phase A: Batch inject YAML frontmatter into old-format wrong-answer files
# Usage: .\scripts\inject-yaml-frontmatter.ps1 [-DryRun] [-TargetFile "1.md"]

param([switch]$DryRun, [string]$TargetFile = "")

$root = Split-Path -Parent $PSScriptRoot
Write-Host "=== YAML Injection Tool v2 ===" -ForegroundColor Cyan
if ($DryRun) { Write-Host "DRY RUN - preview only" -ForegroundColor Yellow }

# Service patterns: array of @(Pattern, ServiceName, Chapter)
$svcDB = @(
    ,@('AWS Global Accelerator','Global Accelerator','Ch 05')
    ,@('AWS Control Tower','Control Tower','Ch 00')
    ,@('AWS Organizations','Organizations','Ch 00')
    ,@('AWS Transit Gateway','Transit Gateway','Ch 05')
    ,@('AWS Direct Connect','Direct Connect','Ch 05')
    ,@('AWS Step Functions','Step Functions','Ch 07')
    ,@('AWS Secrets Manager','Secrets Manager','Ch 06')
    ,@('AWS Systems Manager','Systems Manager','Ch 08')
    ,@('AWS Storage Gateway','Storage Gateway','Ch 03')
    ,@('AWS Identity Center','Identity Center','Ch 06')
    ,@('AWS CloudFormation','CloudFormation','Ch 12')
    ,@('AWS CloudTrail','CloudTrail','Ch 08')
    ,@('AWS CodePipeline','CodePipeline','Ch 12')
    ,@('AWS CodeBuild','CodeBuild','Ch 12')
    ,@('AWS CodeDeploy','CodeDeploy','Ch 12')
    ,@('AWS DataSync','DataSync','Ch 09')
    ,@('AWS Security Hub','Security Hub','Ch 06')
    ,@('AWS Backup','AWS Backup','Ch 00')
    ,@('AWS Shield','Shield','Ch 06')
    ,@('AWS WAF','WAF','Ch 06')
    ,@('AWS Config','Config','Ch 08')
    ,@('AWS DMS','DMS','Ch 09')
    ,@('AWS MGN','MGN','Ch 09')
    ,@('AWS KMS','KMS','Ch 06')
    ,@('AWS IAM','IAM','Ch 06')
    ,@('AWS Glue','Glue','Ch 10')
    ,@('AWS Lambda','Lambda','Ch 01')
    ,@('AWS PrivateLink','PrivateLink','Ch 05')
    ,@('AWS Outposts','Outposts','Ch 13')
    ,@('Amazon API Gateway','API Gateway','Ch 07')
    ,@('Amazon CloudFront','CloudFront','Ch 05')
    ,@('Amazon CloudWatch','CloudWatch','Ch 08')
    ,@('Amazon DynamoDB','DynamoDB','Ch 04')
    ,@('Amazon ElastiCache','ElastiCache','Ch 04')
    ,@('Amazon EventBridge','EventBridge','Ch 07')
    ,@('Amazon GuardDuty','GuardDuty','Ch 06')
    ,@('Amazon AppStream','AppStream','Ch 13')
    ,@('Amazon WorkSpaces','WorkSpaces','Ch 13')
    ,@('Amazon Route 53','Route 53','Ch 05')
    ,@('Amazon Cognito','Cognito','Ch 06')
    ,@('Amazon Redshift','Redshift','Ch 10')
    ,@('Amazon SageMaker','SageMaker','Ch 11')
    ,@('Amazon Kinesis','Kinesis','Ch 10')
    ,@('Amazon Athena','Athena','Ch 10')
    ,@('Amazon Aurora','Aurora','Ch 04')
    ,@('Amazon SQS','SQS','Ch 07')
    ,@('Amazon SNS','SNS','Ch 07')
    ,@('Amazon S3','S3','Ch 03')
    ,@('Amazon EC2','EC2','Ch 01')
    ,@('Amazon EBS','EBS','Ch 03')
    ,@('Amazon ECS','ECS','Ch 02')
    ,@('Amazon EKS','EKS','Ch 02')
    ,@('Amazon EFS','EFS','Ch 03')
    ,@('Amazon EMR','EMR','Ch 10')
    ,@('Amazon FSx','FSx','Ch 03')
    ,@('Amazon RDS','RDS','Ch 04')
    ,@('Amazon VPC','VPC','Ch 05')
    ,@('AWS RAM','RAM','Ch 00')
    ,@('Elastic Load Balancer|Application Load Balancer|Network Load Balancer','ELB','Ch 01')
    ,@('NAT Gateway|NAT gateway','NAT Gateway','Ch 05')
    ,@('Internet Gateway|internet gateway','Internet Gateway','Ch 05')
    ,@('AWS DRS|Elastic Disaster Recovery','DRS','Ch 00')
    ,@('AWS Budgets','Budgets','Ch 00')
    ,@('Cost Explorer','Cost Explorer','Ch 00')
    ,@('Tag Policies|tag policy','Tag Policies','Ch 00')
    ,@('AWS SCT|Schema Conversion Tool','SCT','Ch 09')
    ,@('Snowball|Snow Family','Snowball','Ch 09')
    ,@('Transfer Family','Transfer Family','Ch 09')
    ,@('Amazon QuickSight','QuickSight','Ch 10')
    ,@('Amazon Bedrock','Bedrock','Ch 11')
    ,@('AWS X-Ray','X-Ray','Ch 08')
    ,@('Amazon Inspector','Inspector','Ch 06')
    ,@('AWS Macie','Macie','Ch 06')
    ,@('AWS Artifact','Artifact','Ch 06')
    ,@('Trusted Advisor','Trusted Advisor','Ch 08')
    ,@('Service Catalog','Service Catalog','Ch 08')
    ,@('Auto Scaling','Auto Scaling','Ch 01')
    ,@('AWS Launch Wizard','Launch Wizard','Ch 01')
)

$chToDomain = @{
    'Ch 00'='Domain1'; 'Ch 01'='Domain2'; 'Ch 02'='Domain2'; 'Ch 03'='Domain2'
    'Ch 04'='Domain2'; 'Ch 05'='Domain2'; 'Ch 06'='Domain1'; 'Ch 07'='Domain2'
    'Ch 08'='Domain3'; 'Ch 09'='Domain4'; 'Ch 10'='Domain2'; 'Ch 11'='Domain2'
    'Ch 12'='Domain3'; 'Ch 13'='Domain4'
}

$chToTag = @{
    'Ch 00'='ch00-cross-cutting'; 'Ch 01'='ch01-compute'; 'Ch 02'='ch02-containers'
    'Ch 03'='ch03-storage'; 'Ch 04'='ch04-database'; 'Ch 05'='ch05-networking'
    'Ch 06'='ch06-security'; 'Ch 07'='ch07-integration'; 'Ch 08'='ch08-management'
    'Ch 09'='ch09-migration'; 'Ch 10'='ch10-analytics'; 'Ch 11'='ch11-ml'
    'Ch 12'='ch12-devtools'; 'Ch 13'='ch13-euc'
}

$domToTag = @{
    'Domain1'='domain/org-complexity'; 'Domain2'='domain/new-solutions'
    'Domain3'='domain/continuous-improvement'; 'Domain4'='domain/migration'
}

# Build files list
if ($TargetFile) {
    $files = @(Get-ChildItem "$root\$TargetFile" -ErrorAction SilentlyContinue)
} else {
    $files = Get-ChildItem "$root\[0-9]*.md" | Where-Object { $_.Name -match '^\d+\.md$' } | Sort-Object { [int]$_.BaseName }
}

$total = 0; $injected = 0; $skipped = 0

foreach ($file in $files) {
    $total++
    $raw = Get-Content $file.FullName -Raw -Encoding UTF8
    if ($raw -match '^---') { $skipped++; continue }
    
    # Detect services
    $foundSvc = @{}
    $chCount = @{}
    foreach ($entry in $svcDB) {
        $pattern = $entry[0]
        $svc = $entry[1]
        $ch = $entry[2]
        if ($raw -match $pattern) {
            if (-not $foundSvc.ContainsKey($svc)) {
                $foundSvc[$svc] = $ch
            }
            $chCount[$ch] = 1 + $(if ($chCount[$ch]) { $chCount[$ch] } else { 0 })
        }
    }
    
    if ($foundSvc.Count -eq 0) {
        $foundSvc['General'] = 'Ch 00'
        $chCount['Ch 00'] = 1
    }
    
    # Determine primary chapter (most frequent)
    $priCh = 'Ch 00'; $maxCnt = 0
    foreach ($k in $chCount.Keys) { if ($chCount[$k] -gt $maxCnt) { $maxCnt = $chCount[$k]; $priCh = $k } }
    
    $domain = $chToDomain[$priCh]
    if (-not $domain) { $domain = 'Domain2' }
    $chTag = $chToTag[$priCh]
    if (-not $chTag) { $chTag = 'ch00-cross-cutting' }
    $domTag = $domToTag[$domain]
    if (-not $domTag) { $domTag = 'domain/new-solutions' }
    
    # Difficulty heuristic
    $diff = '🟡'; $interview = '🎤🎤'
    if ($raw -match 'MOST cost-effective|LEAST operational|BEST fit|Choose two|Choose three|RPO.*RTO|DR.*strategy|anti-pattern|Which solution') { $diff = '🔴'; $interview = '🎤🎤🎤' }
    elseif ($raw -match 'maximum |minimum |What is the |Which of the following (correctly |)describes') { $diff = '🟢'; $interview = '🎤' }
    
    $qid = [int]$file.BaseName
    
    # Generate YAML
    $svcLines = ($foundSvc.Keys | Sort-Object | ForEach-Object { "  - $_" }) -join "`n"
    $svcTags = ($foundSvc.Keys | Sort-Object | ForEach-Object { $t = $_ -replace ' ','-' -replace '^AWS-','' -replace '^Amazon-',''; "  - service/" + $t.ToLower() }) -join "`n"
    
    $yaml = @"
---
qid: $qid
chapter: "$priCh"
services:
$svcLines
exam_domains:
  - $domain
tags:
  - aws
  - $domTag
  - chapter/$chTag
  - resource/wrong-answer
$svcTags
difficulty: $diff
interview_relevance: $interview
---
"@
    $newContent = $yaml + "`n" + $raw
    
    if ($DryRun) {
        $svcNames = ($foundSvc.Keys -join ', ')
        Write-Host "DRY: $($file.Name) -> $priCh, $($foundSvc.Count) svc [$svcNames]"
    } else {
        [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.UTF8Encoding]::new($false))
        Write-Host "OK: $($file.Name) [$priCh, $($foundSvc.Count) svc]" -ForegroundColor Green
    }
    $injected++
}

Write-Host "`n=== Summary ===" -ForegroundColor Cyan
Write-Host "Total: $total | Injected: $injected | Skipped (had YAML): $skipped"
if ($DryRun) { Write-Host "Rerun without -DryRun to apply" -ForegroundColor Yellow }
