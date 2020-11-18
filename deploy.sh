docker build -t astrego/multi-client:latest -t astrego/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t astrego/multi-server:latest -t astrego/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t astrego/multi-worker:latest -t astrego/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push astrego/multi-client:latest
docker push astrego/multi-server:latest
docker push astrego/multi-worker:latest

docker push astrego/multi-client:$SHA
docker push astrego/multi-server:$SHA
docker push astrego/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=astrego/multi-server:$SHA
kubectl set image deployments/client-deployment client=astrego/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=astrego/multi-worker:$SHA