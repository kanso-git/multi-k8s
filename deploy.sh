docker build -t kansodocker/multi-client:latest -t kansodocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kansodocker/multi-server:latest -t kansodocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kansodocker/multi-worker:latest -t kansodocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kansodocker/multi-client:latest
docker push kansodocker/multi-server:latest
docker push kansodocker/multi-worker:latest

docker push kansodocker/multi-client:$SHA
docker push kansodocker/multi-server:$SHA
docker push kansodocker/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=kansodocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=kansodocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kansodocker/multi-worker:$SHA