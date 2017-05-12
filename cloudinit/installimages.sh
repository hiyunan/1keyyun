#!/bin/bash
images=('quay.io/coreos/hyperkube:v1.5.4_coreos.0' 'gcr.io/google_containers/pause:3.0' 'gcr.io/google_containers/kubedns-amd64:1.9' 'gcr.io/google_containers/kube-dnsmasq-amd64:1.4' 'gcr.io/google_containers/dnsmasq-metrics-amd64:1.0' 'gcr.io/google_containers/exechealthz-amd64:1.2' 'gcr.io/google_containers/cluster-proportional-autoscaler-amd64:1.0.0' 'gcr.io/google_containers/pause-amd64:3.0' 'gcr.io/google_containers/heapster:v1.2.0' 'gcr.io/google_containers/addon-resizer:1.6' 'gcr.io/google_containers/kubernetes-dashboard-amd64:v1.5.0' 'quay.io/calico/node:v0.23.0' 'quay.io/calico/cni:v1.5.2' 'calico/kube-policy-controller:v0.4.0' 'gcr.io/kubernetes-helm/tiller:v2.4.1')
i=0  
mkdir -p File/imagestar/
for var in ${images[@]};
do
#echo ${images[$i]}

OLD_IFS="$IFS" 
IFS=":" 
#echo ${images[$i]}
arr=(${images[$i]})
image=${arr[0]}
tag=${arr[1]}
echo ${image}
echo $tag
imagesstr=`docker images | grep ${image}    | grep ${tag} | awk -v val=${image} ' {  if ( $1 == val )   print $0 } '`
echo $imagesstr
if [ -z "$imagesstr" ];then
docker pull ${image}:${tag}
fi
imagestr=${image//\//.}
oFile="File/imagestar/${imagestr/:/}${tag}"

echo $oFile
if [ ! -f $oFile ]; then
  docker save ${image}:${tag} -o $oFile

fi
let i++
IFS="$OLD_IFS"
done
# ExecStartPre=/usr/bin/wget -N -P /opt/bin https://raw.githubusercontent.com/coreos/coreos-kubernetes/master/lib/init-ssl
# ExecStartPre=/usr/bin/wget -N -P /opt/bin https://raw.githubusercontent.com/coreos/coreos-kubernetes/master/lib/init-ssl-ca
#        ExecStartPre=/usr/bin/wget -N -P /opt/bin ${K8SRELEASE}/kubectl
#        ExecStartPre=/usr/bin/chmod +x /opt/bin/kubectl
#        ExecStartPre=/usr/bin/wget -N -P /opt/bin ${K8SRELEASE}/kubelet
#        ExecStartPre=/usr/bin/chmod +x /opt/bin/kubelet
#        ExecStartPre=/usr/bin/wget -N -P /opt/cni/bin ${CALICORELEASE}/calico
#        ExecStartPre=/usr/bin/chmod +x /opt/cni/bin/calico
#        ExecStartPre=/usr/bin/wget -N -P /opt/cni/bin ${CALICORELEASE}/calico-ipam
#        ExecStartPre=/usr/bin/chmod +x /opt/cni/bin/calico-ipam
#/calicoctl


