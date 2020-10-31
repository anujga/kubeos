# dashboard

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.4/aio/deploy/recommended.yaml
kubectl apply -f dashboard-admin.yaml
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

 
# presto-crd
# todo:  metering-operator

kubectl apply -f https://starburstdata.s3.us-east-2.amazonaws.com/k8s/341-e-k8s-0.35/service_account.yaml
kubectl apply -f https://starburstdata.s3.us-east-2.amazonaws.com/k8s/341-e-k8s-0.35/role.yaml
kubectl apply -f https://starburstdata.s3.us-east-2.amazonaws.com/k8s/341-e-k8s-0.35/role_binding.yaml
kubectl apply -f https://starburstdata.s3.us-east-2.amazonaws.com/k8s/341-e-k8s-0.35/presto_v1_crd.yaml
kubectl apply -f https://starburstdata.s3.us-east-2.amazonaws.com/k8s/341-e-k8s-0.35/operator.yaml

# presto instance
kubectl create secret generic aws-secret-name --from-file=/home/anuj/.aws/secret
kubectl apply -f presto-1x8G.yaml

helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm install --set persistence.enabled=true superset stable/superset
#inside the pod run this script `bash init_superset.sh development-mode` to
# create the default user/passwd = admin/admin

#prom
# todo: kube-prometheus

kubectl create -f https://operatorhub.io/install/prometheus.yaml

# elastic

kubectl create -f https://operatorhub.io/install/elastic-cloud-eck.yaml
kubectl apply -f elasticsearch.yaml

#L7
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.35.0/deploy/static/provider/aws/deploy.yaml

#kubeflow
# kubectl delete -f https://operatorhub.io/install/kubeflow.yaml
wget https://github.com/kubeflow/kfctl/releases/download/v1.1.0/kfctl_v1.1.0-0-g9a3621e_linux.tar.gz
wget https://github.com/weaveworks/eksctl/releases/download/0.28.1/eksctl_Linux_amd64.tar.gz
export CONFIG_URI="https://raw.githubusercontent.com/kubeflow/manifests/v1.1-branch/kfdef/kfctl_aws.v1.1.0.yaml"

export AWS_CLUSTER_NAME=staging-eks-GP1v
aws iam list-roles \
    | jq -r ".Roles[] \
    | select(.RoleName \
    | startswith(\"eksctl-$AWS_CLUSTER_NAME\") and contains(\"NodeInstanceRole\")) \
    .RoleName"

mkdir ${AWS_CLUSTER_NAME} && cd ${AWS_CLUSTER_NAME}
wget -O kfctl_aws.yaml $CONFIG_URI
kfctl apply -V -f kfctl_aws.yaml


# jenkins

curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-linux-amd64.tar.gz" | tar xzv "jx"


mkdir -p  ~/.config/octant/plugins
curl -L https://github.com/jenkins-x/octant-jx/releases/download/v0.0.27/octant-jx-linux-amd64.tar.gz | tar xzv 
mv octant-* ~/.config/octant/plugins


curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
sudo install skaffold /usr/local/bin/

go get github.com/cespare/reflex

aws ecr get-login-password | docker login --username AWS --password-stdin 004245605591.dkr.ecr.ap-south-1.amazonaws.com

aws ecr get-login-password
