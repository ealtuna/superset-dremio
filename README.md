# superset-dremio

Using the Superset project official Helm chart and changing the used image for the one generated using the Dockerfile in the root of this repository (Available as ealtuna/superset-pyodbc).

    helm install --dependency-update superset ./helm/superset 

## Connect to Superset service

In order to discover the external address for the service:

    export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services superset)
    export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
    echo http://$NODE_IP:$NODE_PORT

## Using a Dremio datasource with a VPN

If the instance of Dremio to connect is inside a VPN, you need to create a local bind to the external service:

    ssh -i $(minikube ssh-key) docker@$(minikube ip) -R 31010:10.9.100.85:31010 -R 9047:10.9.100.85:9047
    minikubeNode=$(ip route get 1 | sed -n 's/^.*src \([0-9.]*\) .*$/\1/p')
    curl http://${minikubeNode}:9047/
    echo $minikubeNode
