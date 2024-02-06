# /bin/bash

curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store-${VERSION}.tar.gz \
${NEXUS_REPO_URL}/repository/${NEXUS_REPO_FRONTEND_NAME}/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo tar -C "/opt/sausage-store/static/dist/" -xvf sausage-store-${VERSION}.tar.gz
rm -f sausage-store-${VERSION}.tar.gz