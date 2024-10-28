docker build -t serhiidocker/multi-client:latest -t serhiidocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t serhiidocker/multi-server:latest -t serhiidocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t serhiidocker/multi-worker:latest -t serhiidocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push serhiidocker/multi-client:latest
docker push serhiidocker/multi-server:latest
docker push serhiidocker/multi-worker:latest

docker push serhiidocker/multi-client:$SHA
docker push serhiidocker/multi-server:$SHA
docker push serhiidocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=serhiidocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=serhiidocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=serhiidocker/multi-worker:$SHA