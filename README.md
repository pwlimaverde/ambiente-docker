# Ambiente Docker - Smart Core Assistant

![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)
![Docker](https://img.shields.io/badge/Docker-20.10+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

Ambiente Docker completo para desenvolvimento e deploy de aplicações Python com integração de serviços de chat e IA.

## 📋 Visão Geral

Este projeto fornece um ambiente Docker containerizado que inclui:

- **Ambiente de Chat Separado**: Evolution API, PostgreSQL, Redis e Ollama
- **Configuração Modular**: Serviços independentes e reutilizáveis
- **Scripts de Automação**: Setup e validação automatizados
- **Documentação Completa**: Guias detalhados de uso e configuração

## 🏗️ Estrutura do Projeto

```
ambiente-docker/
├── ambiente_chat/              # Ambiente de chat separado
│   ├── docker-compose.yml      # Configuração dos serviços de chat
│   ├── .env.example            # Variáveis de ambiente de exemplo
│   ├── .gitignore              # Arquivos ignorados pelo Git
│   ├── README.md               # Documentação do ambiente de chat
│   ├── INSTRUCOES_USO.md       # Instruções detalhadas de uso
│   ├── setup.bat/.sh           # Scripts de configuração
│   ├── validate_setup.bat/.sh  # Scripts de validação
│   └── migrate_from_main.bat   # Script de migração
├── .gitignore                  # Gitignore principal do projeto
├── README.md                   # Este arquivo
├── CHANGELOG.md                # Histórico de mudanças
├── LICENSE                     # Licença do projeto
└── CONTRIBUTING.md             # Guia de contribuição
```

## 🚀 Início Rápido

### Pré-requisitos

- [Docker](https://www.docker.com/get-started) 20.10+
- [Docker Compose](https://docs.docker.com/compose/install/) 2.0+
- Windows 10/11 ou Linux/macOS

### Instalação

1. **Clone o repositório**
   ```bash
   git clone <url-do-repositorio>
   cd ambiente-docker
   ```

2. **Configure o ambiente de chat**
   ```bash
   # Windows
   cd ambiente_chat
   setup.bat
   
   # Linux/macOS
   cd ambiente_chat
   ./setup.sh
   ```

3. **Inicie os serviços**
   ```bash
   docker-compose up -d
   ```

4. **Valide a instalação**
   ```bash
   # Windows
   validate_setup.bat
   
   # Linux/macOS
   ./validate_setup.sh
   ```

## 🔧 Configuração

### Variáveis de Ambiente

Copie o arquivo `.env.example` para `.env` e configure as seguintes variáveis:

```bash
# Configurações do Evolution API
EVOLUTION_API_KEY=sua-chave-api-aqui

# Configurações de Webhook
WEBHOOK_GLOBAL_URL=http://host.docker.internal:8000/oraculo/webhook_whatsapp/

# Configurações do Servidor
SERVER_URL=http://localhost:8080
```

### Portas dos Serviços

| Serviço | Porta | Descrição |
|---------|-------|----------|
| Evolution API | 8080 | API para integração WhatsApp |
| PostgreSQL | 5432 | Banco de dados |
| Redis | 6379 | Cache e sessões |
| Ollama | 11434 | Servidor de modelos de IA |

## 📚 Documentação

### Guias Principais

- [**Instruções de Uso**](ambiente_chat/INSTRUCOES_USO.md) - Guia completo de uso
- [**README do Chat**](ambiente_chat/README.md) - Documentação específica do ambiente de chat
- [**Changelog**](CHANGELOG.md) - Histórico de mudanças
- [**Contribuição**](CONTRIBUTING.md) - Como contribuir com o projeto

### Comandos Úteis

```bash
# Verificar status dos serviços
docker-compose ps

# Ver logs dos serviços
docker-compose logs -f

# Parar todos os serviços
docker-compose down

# Rebuild dos containers
docker-compose up --build -d

# Limpar volumes (CUIDADO: remove dados)
docker-compose down -v
```

## 🔍 Monitoramento e Logs

### Verificação de Saúde

Todos os serviços incluem health checks automáticos:

```bash
# Verificar saúde dos containers
docker-compose ps

# Logs específicos de um serviço
docker-compose logs evolution-api
docker-compose logs postgres
docker-compose logs redis
docker-compose logs ollama
```

### Troubleshooting

1. **Serviços não iniciam**
   - Verifique se as portas não estão em uso
   - Confirme se o Docker está rodando
   - Valide o arquivo `.env`

2. **Problemas de conectividade**
   - Verifique a rede Docker: `docker network ls`
   - Teste conectividade entre containers

3. **Problemas de permissão**
   - No Windows, execute como Administrador
   - No Linux/macOS, verifique permissões dos scripts

## 🤝 Contribuição

Contribuições são bem-vindas! Por favor, leia o [guia de contribuição](CONTRIBUTING.md) antes de submeter pull requests.

### Processo de Desenvolvimento

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🆘 Suporte

Se você encontrar problemas ou tiver dúvidas:

1. Verifique a [documentação](ambiente_chat/INSTRUCOES_USO.md)
2. Consulte as [issues existentes](../../issues)
3. Abra uma [nova issue](../../issues/new) se necessário

## 🔄 Versionamento

Usamos [SemVer](http://semver.org/) para versionamento. Para as versões disponíveis, veja as [tags neste repositório](../../tags).

## ✨ Funcionalidades

- ✅ Ambiente Docker completo
- ✅ Configuração automatizada
- ✅ Scripts de validação
- ✅ Documentação completa
- ✅ Health checks automáticos
- ✅ Logs centralizados
- ✅ Ambiente modular e reutilizável

## 🗺️ Roadmap

- [ ] Adicionar monitoramento com Prometheus
- [ ] Implementar backup automático
- [ ] Adicionar testes automatizados
- [ ] Criar dashboard de monitoramento
- [ ] Implementar CI/CD pipeline

---

**Desenvolvido com ❤️ para facilitar o desenvolvimento com Docker**