#! bin/sh
#Deploy Kube-flannel & etcd-ha-operator

 kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
 
 #Replace the nodenade with the name of the node in the cluster before launching the bash command
 kubectl patch node <nodename> -p '{"spec":{"podCIDR":"10.244.0.0/16"}}'
 
 kubectl create -f https://raw.githubusercontent.com/openshift/etcd-ha-operator/master/deploy/rbac.yaml
 kubectl create -f https://raw.githubusercontent.com/openshift/etcd-ha-operator/master/deploy/crd.yaml
 kubectl create -f https://raw.githubusercontent.com/openshift/etcd-ha-operator/master/deploy/restore_crd.yaml
 kubectl create -f https://raw.githubusercontent.com/openshift/etcd-ha-operator/master/deploy/backup_crd.yaml
 kubectl create -f https://raw.githubusercontent.com/openshift/etcd-ha-operator/master/deploy/operator.yaml
 kubectl create -f https://raw.githubusercontent.com/openshift/etcd-ha-operator/master/deploy/cr.yaml
 
 #Install open vswitch in this machine as well the worker node
sudo apt install openvswitch-switch -y
sudo ovs-vsctl add-br br1
 kubectl apply -f ovs-cni.yml
kubectl apply -f https://github.com/k8snetworkplumbingwg/multus-cni/tree/master/deployments/ multus-daemonset.yml
kubectl apply -f ovs-net-crd.yaml

#Launch the pods
cd Kubernetes deployment  #Check if the folder name matches with this one
 kubectl apply -f prom-node-exporter.yaml
 
#Deploy mysql, mano, nfvo

 kubectl apply -f nfvo-service-account-agent.yaml
 kubectl apply -f mysql-deploy.yaml
 kubectl apply -f kube5gnfvo.yaml
kubectl apply -f 5gmano-deploy.yaml

#5GC
 kubectl apply -f unix-daemonset.yaml   
 kubectl apply -f free5gc-mongodb.yaml
 kubectl apply -f free5gc-configmap.yaml
kubectl apply -f free5gc-nrf.yaml
 kubectl apply -f free5gc-ausf.yaml
 kubectl apply -f free5gc-smf.yaml
 kubectl apply -f free5gc-nssf.yaml
 kubectl apply -f free5gc-pcf.yaml
 kubectl apply -f free5gc-udm.yaml
 kubectl apply -f free5gc-udr.yaml
kubectl apply -f free5gc-amf.yaml
