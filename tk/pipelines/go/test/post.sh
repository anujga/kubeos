git pull origin master
cat VERSION
aws ecr list-images --repository-name prod/hello-go
curl http://localhost:8080/api/charts/hello-go | jq ".[].version"
