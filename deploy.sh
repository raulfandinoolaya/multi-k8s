docker build -t calcas0731/multi-client:latest -t calcas0731/multi-client:$SHA -f ./client/Dockerfile .client
docker build -t calcas0731/multi-server:latest -t calcas0731/multi-server:$SHA -f ./server/Dockerfile .server
docker build -t calcas0731/multi-worker:latest -t calcas0731/multi-worker:$SHA -f ./worker/Dockerfile .worker

docker push calcas0731/multi-client:latest
docker push calcas0731/multi-server:latest
docker push calcas0731/multi-worker:latest

docker push calcas0731/multi-client:$SHA
docker push calcas0731/multi-server:$SHA
docker push calcas0731/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=calcas0731/multi-server:$SHA
kubectl set image deployments/client-deployment client=calcas0731/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=calcas0731/multi-worker:$SHA
