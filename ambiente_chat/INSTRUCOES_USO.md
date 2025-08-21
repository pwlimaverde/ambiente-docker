# Instruções de Uso - Ambiente Chat Separado

## Visão Geral

Este ambiente foi criado para separar completamente os serviços de chat (Evolution API e Ollama) do ambiente principal da aplicação Django. Isso permite:

- **Isolamento de dados**: Recriar a base de dados principal sem afetar os dados de chat
- **Versionamento independente**: Versionar e usar este ambiente em outras pastas/projetos
- **Manutenção simplificada**: Gerenciar os serviços de chat independentemente
- **Escalabilidade**: Facilitar deploy em ambientes separados

## Estrutura de Arquivos

```
ambiente_chat/
├── docker-compose.yml          # Configuração principal dos serviços
├── .env.example               # Exemplo de variáveis de ambiente
├── .gitignore                 # Arquivos a serem ignorados pelo Git
├── README.md                  # Documentação completa
├── INSTRUCOES_USO.md         # Este arquivo
├── setup.bat                  # Script de configuração (Windows)
├── setup.sh                   # Script de configuração (Linux/Mac)
├── validate_setup.bat         # Script de validação (Windows)
├── validate_setup.sh          # Script de validação (Linux/Mac)
└── migrate_from_main.bat      # Script de migração do ambiente atual
```

## Configuração Inicial

### Opção 1: Configuração Limpa (Novo Ambiente)

```bash
# Windows
cd ambiente_chat
setup.bat

# Linux/Mac
cd ambiente_chat
./setup.sh
```

### Opção 2: Migração do Ambiente Atual

```bash
# Windows (execute na pasta ambiente_chat)
migrate_from_main.bat
```

## Uso Diário

### Iniciar Serviços

```bash
cd ambiente_chat
docker-compose up -d
```

### Parar Serviços

```bash
cd ambiente_chat
docker-compose down
```

### Verificar Status

```bash
# Windows
validate_setup.bat

# Linux/Mac
./validate_setup.sh
```

### Ver Logs

```bash
# Todos os serviços
docker-compose logs -f

# Serviço específico
docker-compose logs -f evolution-api
docker-compose logs -f ollama
```

## Integração com Aplicação Principal

### 1. Configurar Variáveis de Ambiente

No arquivo `.env` da aplicação principal, configure:

```env
# Ollama (externo)
OLLAMA_HOST=localhost
OLLAMA_PORT=11434
OLLAMA_BASE_URL=http://localhost:11434

# Evolution API (externo)
EVOLUTION_API_URL=http://localhost:8080
EVOLUTION_API_KEY=sua-chave-aqui
```

### 2. Usar Docker Compose Principal Atualizado

```bash
# Na pasta raiz do projeto
docker-compose -f docker-compose.main.yml up -d
```

## Versionamento

### Preparar para Versionamento

1. Configure o arquivo `.env` com suas credenciais
2. Teste o ambiente com `validate_setup.bat`
3. Faça commit dos arquivos (o `.env` será ignorado pelo `.gitignore`)

```bash
git add ambiente_chat/
git commit -m "feat: adicionar ambiente chat separado"
```

### Usar em Outra Pasta/Projeto

1. Copie a pasta `ambiente_chat` para o novo local
2. Configure o arquivo `.env` com as credenciais apropriadas
3. Execute `setup.bat` ou `setup.sh`

## Portas Utilizadas

- **8080**: Evolution API
- **11434**: Ollama
- **5432**: PostgreSQL (Evolution)
- **6379**: Redis (Evolution)

**Importante**: Certifique-se de que essas portas não estejam em uso por outros serviços.

## Backup e Restauração

### Backup Manual

```bash
# Criar pasta de backup
mkdir backups

# Backup PostgreSQL
docker-compose exec postgres pg_dump -U evolution evolution > backups/postgres_backup.sql

# Backup volumes
docker run --rm -v ambiente_chat_postgres_data:/data -v $(pwd)/backups:/backup alpine tar czf /backup/postgres_data.tar.gz -C /data .
docker run --rm -v ambiente_chat_ollama_data:/data -v $(pwd)/backups:/backup alpine tar czf /backup/ollama_data.tar.gz -C /data .
```

### Restauração

```bash
# Restaurar PostgreSQL
docker-compose exec -T postgres psql -U evolution evolution < backups/postgres_backup.sql

# Restaurar volumes
docker run --rm -v ambiente_chat_postgres_data:/data -v $(pwd)/backups:/backup alpine tar xzf /backup/postgres_data.tar.gz -C /data
```

## Troubleshooting

### Problemas Comuns

1. **Porta em uso**: Verifique se as portas 8080, 11434, 5432, 6379 estão livres
2. **Permissões**: No Linux/Mac, certifique-se de que os scripts `.sh` são executáveis
3. **Docker não iniciado**: Verifique se o Docker Desktop está rodando
4. **Webhook não funciona**: Verifique a URL do webhook no arquivo `.env`

### Comandos de Diagnóstico

```bash
# Verificar containers
docker-compose ps

# Verificar logs de erro
docker-compose logs --tail=50 evolution-api
docker-compose logs --tail=50 ollama

# Testar conectividade
curl http://localhost:8080
curl http://localhost:11434/api/tags

# Verificar volumes
docker volume ls | grep ambiente_chat
```

## Suporte

Para problemas ou dúvidas:

1. Verifique os logs com `docker-compose logs`
2. Execute o script de validação
3. Consulte a documentação completa no `README.md`
4. Verifique se todas as variáveis de ambiente estão configuradas corretamente

---

**Nota**: Este ambiente foi projetado para ser completamente independente. Uma vez configurado, pode ser usado em qualquer projeto que precise dos serviços Evolution API e Ollama.