#!/bin/bash
REGION="us-east-1"
ACCOUNT_ID="087143128777"

aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
