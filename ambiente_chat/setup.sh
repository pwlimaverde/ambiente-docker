#!/bin/bash

echo "========================================"
echo "  Smart Core Assistant - Ambiente Chat"
echo "  Script de Configuração para Linux/Mac"
echo "========================================"
echo

# Verificar se Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "ERRO: Docker não encontrado. Instale o Docker primeiro."
    echo "Instruções: https://docs.docker.com/get-docker/"
    exit 1
fi

# Verificar se Docker Compose está disponível
if ! command -v docker-compose &> /dev/null; then
    echo "ERRO: Docker Compose não encontrado."
    echo "Instruções: https://docs.docker.com/compose/install/"
    exit 1
fi

echo "[1/4] Verificando arquivos de configuração..."
if [ ! -f ".env" ]; then
    echo "Criando arquivo .env a partir do .env.example..."
    cp ".env.example" ".env"
    echo
    echo "IMPORTANTE: Edite o arquivo .env com suas configurações antes de continuar!"
    echo "Execute: nano .env ou vim .env"
    echo
    read -p "Pressione Enter após editar o arquivo .env..."
fi

echo "[2/4] Parando serviços existentes (se houver)..."
docker-compose down

echo "[3/4] Baixando imagens Docker..."
docker-compose pull

echo "[4/4] Iniciando serviços..."
docker-compose up -d

echo
echo "========================================"
echo "  Configuração Concluída!"
echo "========================================"
echo
echo "Serviços disponíveis:"
echo "- Evolution API: http://localhost:8080"
echo "- Ollama: http://localhost:11434"
echo "- PostgreSQL: localhost:5432"
echo "- Redis: localhost:6379"
echo
echo "Para verificar o status dos serviços:"
echo "  docker-compose ps"
echo
echo "Para ver os logs:"
echo "  docker-compose logs -f"
echo
echo "Para parar os serviços:"
echo "  docker-compose down"
echo