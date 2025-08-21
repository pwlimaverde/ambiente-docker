@echo off
echo ========================================
echo  Smart Core Assistant - Ambiente Chat
echo  Script de Configuracao para Windows
echo ========================================
echo.

REM Verificar se Docker esta instalado
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERRO: Docker nao encontrado. Instale o Docker Desktop primeiro.
    echo Baixe em: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

REM Verificar se Docker Compose esta disponivel
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERRO: Docker Compose nao encontrado.
    pause
    exit /b 1
)

echo [1/4] Verificando arquivos de configuracao...
if not exist ".env" (
    echo Criando arquivo .env a partir do .env.example...
    copy ".env.example" ".env"
    echo.
    echo IMPORTANTE: Edite o arquivo .env com suas configuracoes antes de continuar!
    echo Pressione qualquer tecla apos editar o arquivo .env...
    pause
)

echo [2/4] Parando servicos existentes (se houver)...
docker-compose down

echo [3/4] Baixando imagens Docker...
docker-compose pull

echo [4/5] Iniciando servicos...
docker-compose up -d

echo [5/5] Aguardando Ollama e baixando modelo mxbai-embed-large...
echo Aguardando Ollama ficar disponivel...
:wait_ollama
timeout /t 5 /nobreak >nul
curl -s http://localhost:11434/api/tags >nul 2>&1
if %errorlevel% neq 0 (
    echo Ollama ainda nao esta pronto, aguardando...
    goto wait_ollama
)

echo Verificando se modelo mxbai-embed-large:latest esta disponivel...
docker exec ollama-chat ollama list | findstr "mxbai-embed-large" >nul 2>&1
if %errorlevel% neq 0 (
    echo Baixando modelo mxbai-embed-large:latest...
    docker exec ollama-chat ollama pull mxbai-embed-large:latest
) else (
    echo Modelo mxbai-embed-large:latest ja esta disponivel!
)

echo.
echo ========================================
echo  Configuracao Concluida!
echo ========================================
echo.
echo Servicos disponiveis:
echo - Evolution API: http://localhost:8080
echo - Ollama: http://localhost:11434
echo - PostgreSQL: localhost:5432
echo - Redis: localhost:6379
echo.
echo Modelos Ollama instalados:
echo - mxbai-embed-large:latest (para embeddings)
echo.
echo Para verificar o status dos servicos:
echo   docker-compose ps
echo.
echo Para verificar modelos do Ollama:
echo   docker exec ollama-chat ollama list
echo.
echo Para ver os logs:
echo   docker-compose logs -f
echo.
echo Para parar os servicos:
echo   docker-compose down
echo.
pause