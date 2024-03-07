kubectl apply -f - <<EOF
---
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
 name: istio-ingressgateway
 namespace: aks-istio-ingress
spec:
 selector:
   istio: aks-istio-ingressgateway-external
 servers:
 - port:
     number: 80
     name: http
     protocol: HTTP
   hosts:
   - '*'
---
apiVersion: apps/v1
kind: Deployment
metadata:
 name: echoserver
 namespace: default
spec:
 replicas: 1
 selector:
   matchLabels:
     run: echoserver
 template:
   metadata:
     labels:
       run: echoserver
   spec:
     containers:
     - name: echoserver
       image: gcr.io/google_containers/echoserver:1.10
       ports:
       - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
 name: echoserver
 namespace: default
spec:
 ports:
 - port: 8080
   protocol: TCP
   targetPort: 8080
 selector:
   run: echoserver
---
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
 name: echoserver
 namespace: default
spec:
 hosts:
   - "*"
 gateways:
   - aks-istio-ingress/istio-ingressgateway
 http:
 - match:
   - uri:
       prefix: "/"
   route:
   - destination:
       host: "echoserver.default.svc.cluster.local"
       port:
         number: 8080
EOF