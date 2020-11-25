export FLUX_VER=v1.2.0
export FLUX_BIN_VER=1.21.0
export BIN_PATH=$HOME/bin
GIT_AUTHUSER=anuj-meson
GIT_AUTHKEY=4a086e0606b384129af5d22b6235dd1188fc0413
GIT_ORG=Meson-ai
GIT_REPO=clusters
# brew install fluxctl

sudo wget https://github.com/fluxcd/flux/releases/download/${FLUX_BIN_VER}/fluxctl_linux_amd64 -O ${BIN_PATH}/fluxctl
sudo chmod +x ${BIN_PATH}/fluxctl

helm repo add fluxcd https://charts.fluxcd.io
kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/${FLUX_VER}/deploy/crds.yaml
kubectl create namespace flux

# ssh-keygen -q -N "" -f ./identity
# kubectl -n flux create secret generic flux-ssh --from-file=./identity

kubectl create secret generic flux-git-auth --namespace flux \
  --from-literal=GIT_AUTHUSER=${GIT_AUTHUSER} \
  --from-literal=GIT_AUTHKEY=${GIT_AUTHKEY}

helm upgrade -i flux fluxcd/flux \
  --set git.path="prod/us-east-2\,staging" \
  --set git.url='https://$(GIT_AUTHUSER):$(GIT_AUTHKEY)@github.com/'"${GIT_ORG}/${GIT_REPO}.git" \
  --set env.secretName=flux-git-auth \
  --namespace flux

helm upgrade -i helm-operator fluxcd/helm-operator \
  --set helm.versions=v3 \
  --namespace flux

fluxctl sync --k8s-fwd-ns=flux

helm install --name chartmuseum stable/chartmuseum \
  -f custom.yaml

helm repo add chartmuseum http://charts.dev.meson.ai
helm search chartmuseum/
