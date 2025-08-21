@echo off
echo ========================================
echo  Validacao do Ambiente Chat
echo ========================================
echo.

echo [1/5] Verificando se os containers estao rodando...
docker-compose ps
echo.

echo [2/5] Testando conexao com PostgreSQL...
docker-compose exec -T postgres pg_isready -U evolution
if %errorlevel% equ 0 (
    echo ✓ PostgreSQL: OK
) else (
    echo ✗ PostgreSQL: ERRO
)
echo.

echo [3/5] Testando conexao com Redis...
docker-compose exec -T redis redis-cli ping
if %errorlevel% equ 0 (
    echo ✓ Redis: OK
) else (
    echo ✗ Redis: ERRO
)
echo.

echo [4/5] Testando Evolution API...
curl -s -o nul -w "%%{http_code}" http://localhost:8080 > temp_status.txt
set /p status=<temp_status.txt
del temp_status.txt
if "%status%" == "200" (
    echo ✓ Evolution API: OK (HTTP %status%)
) else (
    echo ✗ Evolution API: ERRO (HTTP %status%)
)
echo.

echo [5/5] Testando Ollama...
curl -s -o nul -w "%%{http_code}" http://localhost:11434/api/tags > temp_status.txt
set /p status=<temp_status.txt
del temp_status.txt
if "%status%" == "200" (
    echo ✓ Ollama: OK (HTTP %status%)
) else (
    echo ✗ Ollama: ERRO (HTTP %status%)
)
echo.

echo ========================================
echo  Validacao Concluida!
echo ========================================
echo.
echo URLs dos servicos:
echo - Evolution API: http://localhost:8080
echo - Ollama: http://localhost:11434
echo.
echo Para ver logs detalhados:
echo   docker-compose logs [nome-do-servico]
echo.
echo Servicos disponiveis: evolution-api, ollama, postgres, redis
echo.
pause