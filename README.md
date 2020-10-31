# kubeos

# packaging

# Controllers
1. Use helm sdk inside controllers https://pkg.go.dev/helm.sh/helm/v3
2. Use tekton pipelines for orchestrations like backup, update, restore / rollback. No need to manually implement the state machine by updating CRDs. For very simple cases helm hooks may also suffice


