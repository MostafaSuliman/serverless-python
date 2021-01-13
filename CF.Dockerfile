FROM lambci/lambda:build-nodejs8.10

RUN pip install   awscli
WORKDIR /usr/src/app
COPY stack.yml ./
ARG REGION
ARG STAGE

CMD if aws --region $REGION cloudformation update-stack --stack-name $STAGE --template-body file://stack.yml --capabilities CAPABILITY_IAM; then echo "updates the cloudformation"; else echo "No updates"; fi
