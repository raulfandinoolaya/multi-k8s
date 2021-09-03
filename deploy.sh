docker build -t calcas0731/multi-client-k8s:latest -t calcas0731/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t calcas0731/multi-server-k8s:latest -t calcas0731/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t calcas0731/multi-worker-k8s:latest -t calcas0731/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push calcas0731/multi-client-k8s:latest
docker push calcas0731/multi-server-k8s:latest
docker push calcas0731/multi-worker-k8s:latest

docker push calcas0731/multi-client-k8s:$SHA
docker push calcas0731/multi-server-k8s:$SHA
docker push calcas0731/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=calcas0731/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=calcas0731/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=calcas0731/multi-worker-k8s:$SHA
