FROM lambci/lambda:build-nodejs8.10

RUN pip install   awscli
WORKDIR /usr/src/app
COPY stack.yml ./
ARG REGION
ARG STAGE
ARG stack
ARG AWS_ACCESS_KEY_ID=AKIA3B7BIZY2RVSQIAUR
ARG AWS_SECRET_ACCESS_KEY=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
ARG AWS_REGION=us-east-2
## RUN $(aws ecr get-login --region us-east-2 )
RUN aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID \
&& aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY \
&& aws configure set region $AWS_REGION

CMD if aws --region $REGION cloudformation update-stack --stack-name $stack --template-body file://stack.yml --capabilities CAPABILITY_IAM; then echo "updates the cloudformation"; else echo "No updates"; fi
