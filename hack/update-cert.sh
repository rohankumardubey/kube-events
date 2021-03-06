#!/bin/bash

set -e

certsdir="config/certs"

if [ "$(uname)" == "Darwin" ]; then
    sed -i "" -e "s!caBundle:.*!caBundle: $(cat ./config/certs/ca.crt |base64 )!" config/operator/admission.yaml
    sed -i "" -e "s!tls.key:.*!tls.key: $(cat ./config/certs/server.key |base64 )!" config/operator/admission.yaml
    sed -i "" -e "s!tls.crt:.*!tls.crt: $(cat ./config/certs/server.crt |base64 )!" config/operator/admission.yaml
    sed -i "" -e "s!ca.crt:.*!ca.crt: $(cat ./config/certs/ca.crt |base64 )!" config/operator/admission.yaml
else
    sed -i -e "s/caBundle:.*/caBundle: $(cat ./config/certs/ca.crt |base64 -w 0)/" config/operator/admission.yaml
    sed -i -e "s/tls.key:.*/tls.key: $(cat ./config/certs/server.key |base64 -w 0)/" config/operator/admission.yaml
    sed -i -e "s/tls.crt:.*/tls.crt: $(cat ./config/certs/server.crt |base64 -w 0)/" config/operator/admission.yaml
    sed -i -e "s/ca.crt:.*/ca.crt: $(cat ./config/certs/ca.crt |base64 -w 0)/" config/operator/admission.yaml
fi
