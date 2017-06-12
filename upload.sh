docker save -o httpd.tar rhscl/httpd-24-rhel7-tg:latest

scp ./httpd.tar root@orarepo.ora01000.com:/root
ssh root@orarepo.ora01000.com "docker load -i /root/httpd.tar"
ssh root@orarepo.ora01000.com "docker tag rhscl/httpd-24-rhel7-tg:latest 10.0.1.125:5000/rhscl/httpd-24-rhel7:latest && docker rmi rhscl/httpd-24-rhel7-tg:latest"
ssh root@orarepo.ora01000.com "docker push 10.0.1.125:5000/rhscl/httpd-24-rhel7:latest"
ssh root@oramaster.ora01000.com "oc login -u reguser -p reguser"
ssh root@oramaster.ora01000.com "oc import-image rhscl-httpd -n openshift --insecure=true"

