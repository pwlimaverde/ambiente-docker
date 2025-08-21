#!/bin/bash

echo "========================================"
echo "  Validação do Ambiente Chat"
echo "========================================"
echo

echo "[1/5] Verificando se os containers estão rodando..."
docker-compose ps
echo

echo "[2/5] Testando conexão com PostgreSQL..."
if docker-compose exec -T postgres pg_isready -U evolution > /dev/null 2>&1; then
    echo "✓ PostgreSQL: OK"
else
    echo "✗ PostgreSQL: ERRO"
fi
echo

echo "[3/5] Testando conexão com Redis..."
if docker-compose exec -T redis redis-cli ping > /dev/null 2>&1; then
    echo "✓ Redis: OK"
else
    echo "✗ Redis: ERRO"
fi
echo

echo "[4/5] Testando Evolution API..."
status=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)
if [ "$status" = "200" ]; then
    echo "✓ Evolution API: OK (HTTP $status)"
else
    echo "✗ Evolution API: ERRO (HTTP $status)"
fi
echo

echo "[5/5] Testando Ollama..."
status=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:11434/api/tags)
if [ "$status" = "200" ]; then
    echo "✓ Ollama: OK (HTTP $status)"
else
    echo "✗ Ollama: ERRO (HTTP $status)"
fi
echo

echo "========================================"
echo "  Validação Concluída!"
echo "========================================"
echo
echo "URLs dos serviços:"
echo "- Evolution API: http://localhost:8080"
echo "- Ollama: http://localhost:11434"
echo
echo "Para ver logs detalhados:"
echo "  docker-compose logs [nome-do-servico]"
echo
echo "Serviços disponíveis: evolution-api, ollama, postgres, redis"
echo