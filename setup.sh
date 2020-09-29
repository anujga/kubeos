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

