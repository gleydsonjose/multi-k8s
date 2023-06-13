docker build -t gleydsonjose/multi-client:latest -t gleydsonjose/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gleydsonjose/multi-server:latest -t gleydsonjose/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gleydsonjose/multi-worker:latest -t gleydsonjose/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gleydsonjose/multi-client:latest
docker push gleydsonjose/multi-server:latest
docker push gleydsonjose/multi-worker:latest

docker push gleydsonjose/multi-client:$SHA
docker push gleydsonjose/multi-server:$SHA
docker push gleydsonjose/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gleydsonjose/multi-server:$SHA
kubectl set image deployments/client-deployment client=gleydsonjose/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gleydsonjose/multi-worker:$SHA