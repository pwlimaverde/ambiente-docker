@echo off
echo ========================================
echo  Migracao do Ambiente Principal
echo  para Ambiente Chat Separado
echo ========================================
echo.

echo ATENCAO: Este script ira:
echo 1. Parar os servicos do ambiente principal
echo 2. Fazer backup dos dados dos servicos de chat
echo 3. Iniciar o novo ambiente chat separado
echo 4. Restaurar os dados migrados
echo.
set /p confirm="Deseja continuar? (s/N): "
if /i not "%confirm%" == "s" (
    echo Operacao cancelada.
    pause
    exit /b 0
)

echo.
echo [1/6] Parando ambiente principal...
cd ..
docker-compose down

echo [2/6] Criando backups dos dados de chat...
if not exist "ambiente_chat\backups" mkdir "ambiente_chat\backups"

echo Fazendo backup do PostgreSQL (Evolution API)...
docker run --rm -v smart-core-assistant-painel_postgres_data:/data -v "%cd%\ambiente_chat\backups":/backup alpine tar czf /backup/postgres_evolution_backup.tar.gz -C /data .

echo Fazendo backup do Redis...
docker run --rm -v smart-core-assistant-painel_redis_data:/data -v "%cd%\ambiente_chat\backups":/backup alpine tar czf /backup/redis_backup.tar.gz -C /data .

echo Fazendo backup das instancias do Evolution...
docker run --rm -v smart-core-assistant-painel_evolution_instances:/data -v "%cd%\ambiente_chat\backups":/backup alpine tar czf /backup/evolution_instances_backup.tar.gz -C /data .

echo Fazendo backup do Ollama...
docker run --rm -v smart-core-assistant-painel_ollama_data:/data -v "%cd%\ambiente_chat\backups":/backup alpine tar czf /backup/ollama_backup.tar.gz -C /data .

echo [3/6] Entrando no diretorio do ambiente chat...
cd ambiente_chat

echo [4/6] Configurando ambiente chat...
if not exist ".env" (
    copy ".env.example" ".env"
    echo Arquivo .env criado. Edite-o conforme necessario.
)

echo [5/6] Iniciando ambiente chat...
docker-compose up -d

echo Aguardando servicos iniciarem...
timeout /t 30 /nobreak

echo [6/6] Restaurando dados migrados...
echo Parando servicos temporariamente para restauracao...
docker-compose down

echo Criando volumes do novo ambiente...
docker volume create ambiente_chat_postgres_data
docker volume create ambiente_chat_redis_data
docker volume create ambiente_chat_evolution_instances
docker volume create ambiente_chat_ollama_data

echo Restaurando PostgreSQL...
docker run --rm -v ambiente_chat_postgres_data:/data -v "%cd%\backups":/backup alpine tar xzf /backup/postgres_evolution_backup.tar.gz -C /data

echo Restaurando Redis...
docker run --rm -v ambiente_chat_redis_data:/data -v "%cd%\backups":/backup alpine tar xzf /backup/redis_backup.tar.gz -C /data

echo Restaurando instancias Evolution...
docker run --rm -v ambiente_chat_evolution_instances:/data -v "%cd%\backups":/backup alpine tar xzf /backup/evolution_instances_backup.tar.gz -C /data

echo Restaurando Ollama...
docker run --rm -v ambiente_chat_ollama_data:/data -v "%cd%\backups":/backup alpine tar xzf /backup/ollama_backup.tar.gz -C /data

echo Reiniciando ambiente chat...
docker-compose up -d

echo.
echo ========================================
echo  Migracao Concluida!
echo ========================================
echo.
echo O ambiente chat agora esta rodando separadamente.
echo.
echo Proximos passos:
echo 1. Teste o ambiente chat: validate_setup.bat
echo 2. Configure o ambiente principal para usar os servicos externos
echo 3. Inicie o ambiente principal com: docker-compose -f ../docker-compose.main.yml up -d
echo.
echo URLs dos servicos migrados:
echo - Evolution API: http://localhost:8080
echo - Ollama: http://localhost:11434
echo.
pause