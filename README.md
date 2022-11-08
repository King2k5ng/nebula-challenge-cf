# Nebula Techical Challenge Using AWS

In this challenge, i was required to create a website where a visitor can provide their name and the website responds with

 Hello (name that was provided) , your IP address is (IP address of visitor). 
 

## Proposed Solution
The diagram below shows an overveiw of how the solution functions.
![Proposed solution](https://github.com/King2k5ng/nebula-challenge-cf/blob/main/nebula_project.png)


In this solution, I create a webpage that is hosted on an S3 bucket and served using a CloudFront distribution. 
Resources are created using a cloudformation template. This solution take into consideration Cost Optimisation and Scalability 


### Solution Details

This solution creates an S3 bucket that hosts my static website’s files(the files in the assets folder). 
The website is only accessible via CloudFront, not directly from S3.
The CloudFront Distrbution uses the S3 bucket's website endpoint as the origin, with anonymous (public) access allowed.
A cloudFormation template is used to create the resources needed for the solution

### Prerequisites
* AWS account
* AWS CLI
* linux system to run script to automate deployment of resources and uploading website assets to S3 bucket.
* Alternatvly Windows user's can istall Jq to run script using git bash. 