#! /bin/bash

# Descompacta a imagem Docker onde está a build da API
docker load -i vollmed-test-sonarcloud_api.tar

# Renomeia o Docker compose de produção
mv docker-compose-prod.yaml docker-compose.yaml

# Listar os IDs dos containers em execução
container_ids=$(docker ps -q)

# Verificar se há containers em execução
if [ -z "$container_ids" ]; then
    echo "Não há containers em execução."
else
for container_id in $container_ids; do
            echo "Parando container: $container_id"
            docker stop $container_id
done
echo "Todos os containers em execução foram parados."
fi

# Sobe os containers da aplicação
docker compose up -d
