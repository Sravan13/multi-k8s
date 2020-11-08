docker build -t  sravan13/multi-client:latest -t  sravan13/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t  sravan13/multi-server:latest -t  sravan13/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t  sravan13/multi-worker:latest -t  sravan13/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sravan13/multi-client:latest
docker push sravan13/multi-server:latest
docker push sravan13/multi-worker:latest

docker push sravan13/multi-client:$SHA
docker push sravan13/multi-server:$SHA
docker push sravan13/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=sravan13/multi-client:$SHA
kubectl set image deployments/server-deployment server=sravan13/multi-server:$SHA 
kubectl set image deployments/worker-deployment worker=sravan13/multi-worker:$SHA

