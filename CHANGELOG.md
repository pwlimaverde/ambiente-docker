# Changelog

Todos os mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Não Lançado]

### Adicionado
- Estrutura inicial do projeto
- Documentação completa do projeto
- Arquivos de controle de versão

## [0.1.0] - 2024-01-20

### Adicionado
- Ambiente Docker completo para desenvolvimento
- Configuração do Evolution API para integração WhatsApp
- Configuração do PostgreSQL como banco de dados
- Configuração do Redis para cache e sessões
- Configuração do Ollama para modelos de IA local
- Scripts de automação para Windows (setup.bat, validate_setup.bat)
- Scripts de automação para Linux/macOS (setup.sh, validate_setup.sh)
- Script de migração (migrate_from_main.bat)
- Documentação completa em português
- Arquivo .env.example com configurações de exemplo
- Health checks automáticos para todos os serviços
- Rede Docker isolada para comunicação entre serviços
- Volumes persistentes para dados do PostgreSQL e Redis

### Configurado
- Docker Compose com todos os serviços necessários
- Variáveis de ambiente para configuração flexível
- Portas de acesso para todos os serviços
- Restart policies para alta disponibilidade
- Logs centralizados e estruturados

### Documentado
- README.md principal com visão geral do projeto
- README.md específico do ambiente de chat
- INSTRUCOES_USO.md com guia detalhado de uso
- Comentários em português nos arquivos de configuração
- Exemplos de uso e troubleshooting

### Segurança
- Configuração de autenticação para Evolution API
- Isolamento de rede entre serviços
- Variáveis de ambiente para dados sensíveis
- .gitignore configurado para proteger arquivos sensíveis

## Tipos de Mudanças

- `Adicionado` para novas funcionalidades
- `Alterado` para mudanças em funcionalidades existentes
- `Descontinuado` para funcionalidades que serão removidas em breve
- `Removido` para funcionalidades removidas
- `Corrigido` para correções de bugs
- `Segurança` para vulnerabilidades corrigidas

## Links

- [Não Lançado]: https://github.com/seu-usuario/ambiente-docker/compare/v0.1.0...HEAD
- [0.1.0]: https://github.com/seu-usuario/ambiente-docker/releases/tag/v0.1.0

---

**Nota**: Este changelog é mantido manualmente. Para uma lista completa de mudanças, consulte o [histórico de commits](https://github.com/seu-usuario/ambiente-docker/commits/main).