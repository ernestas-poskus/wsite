## Setup

> Setup aws credentials in ~/.aws/credentials

```
[default]
aws_access_key_id = ID
aws_secret_access_key = SECRET
```

## Test

```
curl -v "http://$(terraform output elb_hostname)"
```
