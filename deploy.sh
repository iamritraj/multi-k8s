docker build -t iamritraj/multi-client:latest -t iamritraj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t iamritraj/multi-server:latest -t iamritraj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t iamritraj/multi-worker:latest -t iamritraj/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push iamritraj/multi-client:latest
docker push iamritraj/multi-server:latest
docker push iamritraj/multi-worker:latest

docker push iamritraj/multi-client:$SHA
docker push iamritraj/multi-server:$SHA
docker push iamritraj/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=iamritraj/multi-server:$SHA
kubectl set image deployments/client-deployment client=iamritraj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=iamritraj/multi-worker:$SHA