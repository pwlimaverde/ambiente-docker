# Ambiente Chat - Smart Core Assistant

Este diretório contém a configuração Docker para os serviços de chat (Evolution API e Ollama) separados do ambiente principal da aplicação.

## Serviços Incluídos

- **Evolution API**: API para integração com WhatsApp
- **PostgreSQL**: Banco de dados para Evolution API
- **Redis**: Cache e sessões para Evolution API
- **Ollama**: Servidor de modelos de linguagem local

## Configuração

### 1. Configurar Variáveis de Ambiente

```bash
# Copie o arquivo de exemplo
cp .env.example .env

# Edite o arquivo .env com suas configurações
notepad .env
```

### 2. Configurações Principais

- `EVOLUTION_API_KEY`: Chave de autenticação para Evolution API
- `WEBHOOK_GLOBAL_URL`: URL do webhook para receber eventos do WhatsApp
- `SERVER_URL`: URL base do servidor Evolution API

## Uso

### Iniciar os Serviços

```bash
# Iniciar todos os serviços
docker-compose up -d

# Verificar status dos serviços
docker-compose ps

# Ver logs dos serviços
docker-compose logs -f
```

### Parar os Serviços

```bash
# Parar todos os serviços
docker-compose down

# Parar e remover volumes (CUIDADO: remove dados persistentes)
docker-compose down -v
```

## Portas Expostas

- **8080**: Evolution API
- **11434**: Ollama
- **5432**: PostgreSQL
- **6379**: Redis

## Volumes Persistentes

- `evolution_instances`: Instâncias do WhatsApp
- `postgres_data`: Dados do PostgreSQL
- `redis_data`: Dados do Redis
- `ollama_data`: Modelos e dados do Ollama

## Integração com Aplicação Principal

Para conectar a aplicação principal com este ambiente:

1. Configure as variáveis de ambiente na aplicação principal:
   ```env
   OLLAMA_HOST=localhost
   OLLAMA_PORT=11434
   OLLAMA_BASE_URL=http://localhost:11434
   ```

2. Configure o webhook na Evolution API para apontar para sua aplicação:
   ```env
   WEBHOOK_GLOBAL_URL=http://host.docker.internal:8000/oraculo/webhook_whatsapp/
   ```

## Comandos Úteis

### Ollama

```bash
# Baixar um modelo
docker-compose exec ollama ollama pull llama2

# Listar modelos instalados
docker-compose exec ollama ollama list

# Executar um modelo interativamente
docker-compose exec ollama ollama run llama2
```

### Evolution API

```bash
# Ver logs da Evolution API
docker-compose logs -f evolution-api

# Acessar container da Evolution API
docker-compose exec evolution-api sh
```

### PostgreSQL

```bash
# Conectar ao banco de dados
docker-compose exec postgres psql -U evolution -d evolution

# Backup do banco
docker-compose exec postgres pg_dump -U evolution evolution > backup.sql

# Restaurar backup
docker-compose exec -T postgres psql -U evolution evolution < backup.sql
```

## Troubleshooting

### Problemas Comuns

1. **Porta já em uso**: Verifique se as portas 8080, 11434, 5432 ou 6379 não estão sendo usadas por outros serviços
2. **Webhook não funciona**: Verifique se a URL do webhook está correta e acessível
3. **Ollama não responde**: Aguarde alguns minutos após o start, o Ollama pode demorar para inicializar

### Logs

```bash
# Ver logs de todos os serviços
docker-compose logs

# Ver logs de um serviço específico
docker-compose logs evolution-api
docker-compose logs ollama
docker-compose logs postgres
docker-compose logs redis
```

## Backup e Restauração

### Backup Completo

```bash
# Criar backup dos volumes
docker-compose down
docker run --rm -v ambiente_chat_postgres_data:/data -v $(pwd):/backup alpine tar czf /backup/postgres_backup.tar.gz -C /data .
docker run --rm -v ambiente_chat_ollama_data:/data -v $(pwd):/backup alpine tar czf /backup/ollama_backup.tar.gz -C /data .
docker run --rm -v ambiente_chat_evolution_instances:/data -v $(pwd):/backup alpine tar czf /backup/evolution_backup.tar.gz -C /data .
```

### Restauração

```bash
# Restaurar backup dos volumes
docker-compose down -v
docker volume create ambiente_chat_postgres_data
docker volume create ambiente_chat_ollama_data
docker volume create ambiente_chat_evolution_instances
docker run --rm -v ambiente_chat_postgres_data:/data -v $(pwd):/backup alpine tar xzf /backup/postgres_backup.tar.gz -C /data
docker run --rm -v ambiente_chat_ollama_data:/data -v $(pwd):/backup alpine tar xzf /backup/ollama_backup.tar.gz -C /data
docker run --rm -v ambiente_chat_evolution_instances:/data -v $(pwd):/backup alpine tar xzf /backup/evolution_backup.tar.gz -C /data
```