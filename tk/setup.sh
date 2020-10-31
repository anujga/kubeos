curl -LO https://github.com/tektoncd/cli/releases/download/v0.13.1/tkn_0.13.1_Linux_x86_64.tar.gz
sudo tar xvzf tkn_0.13.1_Linux_x86_64.tar.gz -C ~/bin/ tkn

kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml


kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/git-clone/0.2/git-clone.yaml

kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/v1beta1/kaniko/kaniko.yaml



k apply -f /home/anuj/meson/infra/tk/tk-configs.yaml
tkn task describe echo-hello-world

kubectl create secret generic regcred \
 --from-file=.dockerconfigjson=$HOME/.docker/config.json \
 --type=kubernetes.io/dockerconfigjson

kubectl create secret generic aws-secret --from-file=$HOME/.aws/credentials

