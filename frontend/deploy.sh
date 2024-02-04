# /bin/bash

curl -u std-025-75:7q2g4NSw -o sausage-store-${VERSION}.tar.gz https://nexus.praktikum-services.tech/repository/std-025-75-frontend/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo tar -C "/opt/sausage-store/static/dist/" -xvf sausage-store-${VERSION}.tar.gz
rm -f sausage-store-${VERSION}.tar.gz