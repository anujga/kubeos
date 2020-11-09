curl -LO https://github.com/tektoncd/cli/releases/download/v0.13.1/tkn_0.13.1_Linux_x86_64.tar.gz
sudo tar xvzf tkn_0.13.1_Linux_x86_64.tar.gz -C ~/bin/ tkn

kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
kubectl apply -f https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml



kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/git-clone/0.2/git-clone.yaml


kubectl create secret generic regcred \
 --from-file=.dockerconfigjson=$HOME/.docker/config.json \
 --type=kubernetes.io/dockerconfigjson

kubectl create secret generic aws-secret --from-file=$HOME/.aws/credentials


kubectl create secret generic aws-secret \
  --from-literal=token=$(GITHUB_TOKEN) \
  --from-literal=secret=random-string-data

          
k apply -f /home/anuj/meson/clusters/tk/tk-sa.yaml
k apply -f /home/anuj/meson/clusters/tk/kaniko.yaml
k apply -f /home/anuj/meson/clusters/tk/golang-commons.yaml
k apply -f /home/anuj/meson/clusters/tk/golang-release-ecr-pipeline.yaml


k apply -f /home/anuj/meson/clusters/tk/golang-run.yaml
aws ecr list-images --repository-name prod/hello-go

# k apply -f /home/anuj/meson/infra/tk/tk-configs.yaml
# tkn task describe echo-hello-world

git clone https://github.com/tektoncd/triggers.git

cd triggers/docs/getting-started
kubectl create namespace getting-started
k ns getting-started

kubectl apply -f ./rbac/
kubectl apply -f /home/anuj/meson/clusters/tk/golang-trigger.yaml