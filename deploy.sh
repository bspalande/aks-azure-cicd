#!/bin/sh


cd $TRAVIS_BUILD_DIR/contacts-backend
docker build -t bhavanaaz400/contacts-backend:latest -t bhavanaaz400/contacts-backend:$BUILD_ID -f ./Dockerfile .
cd $TRAVIS_BUILD_DIR
ls -l
echo $PWD
docker build -t bhavanaaz400/contacts-frontend:latest -t bhavanaaz400/contacts-frontend:$BUILD_ID -f ./contacts-frontend/Dockerfile ./contacts-frontend
docker push bhavanaaz400/contacts-backend:latest
docker push bhavanaaz400/contacts-frontend:latest

docker push bhavanaaz400/contacts-backend:$BUILD_ID
docker push bhavanaaz400/contacts-frontend:$BUILD_ID

kubectl apply -f ./contacts-deployment/k8s
kubectl set image deployments/contact-frontend-deployment contacts-frontend=bhavanaaz400/contacts-frontend:$BUILD_ID
kubectl set image deployments/contact-backend-deployment contacts-api=bhavanaaz400/contacts-backend:$BUILD_ID
