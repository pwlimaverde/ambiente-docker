# Guia de Contribuição

Obrigado por considerar contribuir com o projeto Ambiente Docker! Este documento fornece diretrizes e informações sobre como contribuir efetivamente.

## 📋 Índice

- [Código de Conduta](#código-de-conduta)
- [Como Posso Contribuir?](#como-posso-contribuir)
- [Configuração do Ambiente de Desenvolvimento](#configuração-do-ambiente-de-desenvolvimento)
- [Processo de Desenvolvimento](#processo-de-desenvolvimento)
- [Padrões de Código](#padrões-de-código)
- [Convenções de Commit](#convenções-de-commit)
- [Processo de Pull Request](#processo-de-pull-request)
- [Reportando Bugs](#reportando-bugs)
- [Sugerindo Melhorias](#sugerindo-melhorias)

## 📜 Código de Conduta

Este projeto adere a um código de conduta. Ao participar, você deve manter um ambiente respeitoso e inclusivo para todos.

### Nossos Compromissos

- Usar linguagem acolhedora e inclusiva
- Respeitar diferentes pontos de vista e experiências
- Aceitar críticas construtivas graciosamente
- Focar no que é melhor para a comunidade
- Mostrar empatia com outros membros da comunidade

## 🤝 Como Posso Contribuir?

### Tipos de Contribuição

- **Correção de Bugs**: Identifique e corrija problemas existentes
- **Novas Funcionalidades**: Implemente recursos solicitados ou propostos
- **Documentação**: Melhore ou adicione documentação
- **Testes**: Adicione ou melhore a cobertura de testes
- **Otimização**: Melhore performance ou eficiência
- **Refatoração**: Melhore a qualidade do código sem alterar funcionalidade

### Áreas que Precisam de Ajuda

- Documentação em inglês
- Testes automatizados
- Monitoramento e observabilidade
- Otimização de performance
- Suporte a diferentes plataformas

## 🛠️ Configuração do Ambiente de Desenvolvimento

### Pré-requisitos

- Docker 20.10+
- Docker Compose 2.0+
- Git
- Editor de código (recomendado: VS Code)

### Configuração Inicial

1. **Fork o repositório**
   ```bash
   # Clique em "Fork" no GitHub
   ```

2. **Clone seu fork**
   ```bash
   git clone https://github.com/SEU-USUARIO/ambiente-docker.git
   cd ambiente-docker
   ```

3. **Configure o repositório upstream**
   ```bash
   git remote add upstream https://github.com/USUARIO-ORIGINAL/ambiente-docker.git
   ```

4. **Configure o ambiente**
   ```bash
   cd ambiente_chat
   cp .env.example .env
   # Edite o .env com suas configurações
   ```

5. **Teste a configuração**
   ```bash
   # Windows
   validate_setup.bat
   
   # Linux/macOS
   ./validate_setup.sh
   ```

## 🔄 Processo de Desenvolvimento

### Workflow GitFlow

Usamos o GitFlow como modelo de branching. Siga estas convenções:

#### Tipos de Branch

- **`main`**: Branch principal com código estável
- **`develop`**: Branch de desenvolvimento com últimas funcionalidades
- **`feature/nome-da-funcionalidade`**: Novas funcionalidades
- **`bugfix/nome-do-bug`**: Correções de bugs em desenvolvimento
- **`hotfix/nome-do-hotfix`**: Correções urgentes em produção
- **`release/vX.Y.Z`**: Preparação de releases

#### Criando uma Nova Feature

```bash
# Atualize seu repositório
git checkout develop
git pull upstream develop

# Crie uma nova branch
git checkout -b feature/minha-nova-funcionalidade

# Faça suas alterações
# ...

# Commit suas mudanças
git add .
git commit -m "feat: adiciona nova funcionalidade X"

# Push para seu fork
git push origin feature/minha-nova-funcionalidade
```

## 📝 Padrões de Código

### Convenções Gerais

- **Idioma**: Código em inglês, comentários em português
- **Encoding**: UTF-8
- **Line Endings**: LF (Unix)
- **Indentação**: 2 espaços para YAML, 4 espaços para Python

### Nomenclatura

- **Variáveis e Funções**: `snake_case`
- **Classes**: `PascalCase`
- **Constantes**: `UPPER_SNAKE_CASE`
- **Arquivos**: `kebab-case` ou `snake_case`

### Docker e Docker Compose

```yaml
# Bom exemplo
services:
  service_name:
    image: image:tag
    container_name: descriptive-name
    restart: unless-stopped
    environment:
      - VARIABLE_NAME=value
    volumes:
      - volume_name:/path/in/container
    networks:
      - network_name
```

### Documentação

- Use Markdown para documentação
- Inclua exemplos práticos
- Mantenha a documentação atualizada
- Escreva em português claro e objetivo

## 📋 Convenções de Commit

Usamos [Conventional Commits](https://www.conventionalcommits.org/) para padronizar mensagens de commit.

### Formato

```
<tipo>[escopo opcional]: <descrição>

[corpo opcional]

[rodapé opcional]
```

### Tipos de Commit

- **`feat`**: Nova funcionalidade
- **`fix`**: Correção de bug
- **`docs`**: Mudanças na documentação
- **`style`**: Mudanças de formatação (não afetam funcionalidade)
- **`refactor`**: Refatoração de código
- **`test`**: Adição ou modificação de testes
- **`chore`**: Tarefas de manutenção
- **`perf`**: Melhorias de performance
- **`ci`**: Mudanças em CI/CD

### Exemplos

```bash
# Funcionalidade
git commit -m "feat(docker): adiciona health check para postgres"

# Correção
git commit -m "fix(setup): corrige permissões do script setup.sh"

# Documentação
git commit -m "docs: atualiza instruções de instalação"

# Breaking change
git commit -m "feat!: altera estrutura de configuração do .env"
```

## 🔍 Processo de Pull Request

### Antes de Submeter

1. **Teste localmente**
   ```bash
   # Execute os testes
   docker-compose up -d
   # Valide a configuração
   validate_setup.bat  # ou .sh
   ```

2. **Atualize a documentação**
   - README.md se necessário
   - CHANGELOG.md
   - Comentários no código

3. **Verifique o código**
   - Remova código comentado
   - Verifique formatação
   - Confirme que não há secrets no código

### Template de Pull Request

```markdown
## Descrição
Descreva brevemente as mudanças realizadas.

## Tipo de Mudança
- [ ] Bug fix (mudança que corrige um problema)
- [ ] Nova funcionalidade (mudança que adiciona funcionalidade)
- [ ] Breaking change (mudança que quebra compatibilidade)
- [ ] Documentação

## Como Testar
1. Passo 1
2. Passo 2
3. Passo 3

## Checklist
- [ ] Código testado localmente
- [ ] Documentação atualizada
- [ ] CHANGELOG.md atualizado
- [ ] Commits seguem convenção
- [ ] Não há secrets no código
```

### Processo de Review

1. **Automated Checks**: CI/CD executa verificações automáticas
2. **Code Review**: Maintainers revisam o código
3. **Testing**: Testes manuais se necessário
4. **Approval**: Aprovação de pelo menos um maintainer
5. **Merge**: Merge para branch de destino

## 🐛 Reportando Bugs

### Antes de Reportar

1. Verifique se o bug já foi reportado
2. Teste com a versão mais recente
3. Colete informações do ambiente

### Template de Bug Report

```markdown
**Descrição do Bug**
Descrição clara e concisa do problema.

**Passos para Reproduzir**
1. Vá para '...'
2. Clique em '....'
3. Role para baixo até '....'
4. Veja o erro

**Comportamento Esperado**
Descrição do que deveria acontecer.

**Screenshots**
Se aplicável, adicione screenshots.

**Ambiente:**
 - OS: [e.g. Windows 11]
 - Docker Version: [e.g. 20.10.17]
 - Docker Compose Version: [e.g. 2.6.0]

**Logs**
```
Cole os logs relevantes aqui
```

**Contexto Adicional**
Qualquer outra informação relevante.
```

## 💡 Sugerindo Melhorias

### Template de Feature Request

```markdown
**Sua sugestão está relacionada a um problema?**
Descrição clara do problema. Ex: Fico frustrado quando [...]

**Descreva a solução que você gostaria**
Descrição clara e concisa do que você quer que aconteça.

**Descreva alternativas consideradas**
Descrição de soluções ou funcionalidades alternativas.

**Contexto Adicional**
Qualquer outra informação ou screenshots sobre a sugestão.
```

## 🏷️ Labels e Milestones

### Labels Principais

- **`bug`**: Algo não está funcionando
- **`enhancement`**: Nova funcionalidade ou melhoria
- **`documentation`**: Melhorias na documentação
- **`good first issue`**: Bom para iniciantes
- **`help wanted`**: Ajuda extra é bem-vinda
- **`priority: high`**: Alta prioridade
- **`priority: low`**: Baixa prioridade

## 🎯 Roadmap e Prioridades

### Próximas Versões

- **v1.1.0**: Monitoramento e observabilidade
- **v1.2.0**: Testes automatizados
- **v2.0.0**: Suporte multi-plataforma

### Como Contribuir com o Roadmap

1. Participe das discussões nas issues
2. Proponha novas funcionalidades
3. Implemente funcionalidades do roadmap
4. Teste versões beta

## 📞 Contato

Se você tiver dúvidas sobre contribuição:

- Abra uma issue com a label `question`
- Participe das discussões no GitHub
- Consulte a documentação existente

---

**Obrigado por contribuir! 🚀**

Sua contribuição ajuda a tornar este projeto melhor para toda a comunidade.