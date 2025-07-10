# Diretório de Pessoas - PowerApps

Este projeto foi transformado de uma aplicação web JavaScript para Microsoft PowerApps, mantendo a mesma funcionalidade de exibição e atualização de dados de pessoas.

## 📋 Funcionalidades

- **Exibição de Dados**: Lista de pessoas com nome, email e telefone
- **Atualização Automática**: Dados são atualizados automaticamente a cada 10 segundos
- **Atualização Manual**: Botão para atualizar dados manualmente
- **Interface Responsiva**: Design adaptável com tema rosa e azul
- **Dados Simulados**: Geração automática de dados de pessoas brasileiras

## 🏗️ Estrutura PowerApps

```
powerapps/
├── manifest.json                    # Manifesto da aplicação
├── Src/
│   └── MainScreen.fx               # Tela principal com fórmulas Power Fx
├── DataSources/
│   └── PeopleCollection.json       # Definição da fonte de dados
├── Controls/
│   └── ControlDefinitions.json     # Definições dos controles da UI
└── Entropy/
    └── AppCheckerResult.json       # Metadados e entropia da aplicação
```

## 🚀 Como Importar para PowerApps

### Método 1: Importação Manual

1. **Acesse PowerApps Studio**: [make.powerapps.com](https://make.powerapps.com)
2. **Crie um novo app canvas**: Selecione "Canvas app from blank"
3. **Configure a tela principal**:
   - Nome: `MainScreen`
   - Orientação: Portrait
   - Tamanho: Phone (640x1136)

4. **Importe a fonte de dados**:
   - Adicione uma nova Collection chamada `PeopleCollection`
   - Use os dados do arquivo `DataSources/PeopleCollection.json`

5. **Adicione os controles**:
   - Copie as definições de `Controls/ControlDefinitions.json`
   - Configure cada controle conforme especificado

6. **Configure as fórmulas**:
   - Copie o código Power Fx do arquivo `Src/MainScreen.fx`
   - Cole na propriedade `OnVisible` da tela principal

### Método 2: Usando Power Platform CLI

```bash
# Instale o Power Platform CLI
pac install latest

# Autentique-se
pac auth create --url https://[yourorg].crm.dynamics.com

# Crie o pacote da solução
pac solution create --name PeopleDirectory --publisher-name PowerAppsCommunity

# Importe os arquivos
pac canvas create --name "Diretório de Pessoas" --manifest manifest.json
```

## 🎨 Personalização do Tema

O tema utiliza cores baby pink e baby blue:

- **Primary Color**: `#FFB6C1` (Baby Pink)
- **Secondary Color**: `#87CEEB` (Baby Blue)  
- **Accent Color**: `#FF91A4` (Dark Pink)
- **Background**: `#FFFFFF` (White)

### Modificar Cores

Para alterar as cores, edite as propriedades `Fill` e `Color` nos controles:

```powerfx
// Exemplo: Alterar cor do botão
RefreshButton.Fill = RGBA(135, 206, 235, 1)  // Baby Blue
RefreshButton.Color = RGBA(255, 255, 255, 1)  // White Text
```

## 📱 Recursos Implementados

### Componentes Principais

1. **HeaderContainer**: Cabeçalho com título e subtítulo
2. **StatusContainer**: Indicador de status com timestamp
3. **ResultsContainer**: Lista de pessoas em formato de galeria
4. **RefreshButton**: Botão para atualização manual
5. **AutoRefreshTimer**: Timer para atualização automática

### Fórmulas Power Fx

#### Geração de Dados Aleatórios
```powerfx
// Gerar nome aleatório
With(
    {
        _firstNames: ["Ana", "Carlos", "Maria", "João", "Lucia"],
        _lastNames: ["Silva", "Santos", "Oliveira", "Souza", "Rodrigues"]
    },
    Index(_firstNames, RandBetween(1, 5)).Value & " " & 
    Index(_lastNames, RandBetween(1, 5)).Value
)
```

#### Atualização da Collection
```powerfx
// Atualizar dados
ClearCollect(
    PeopleCollection,
    ForAll(
        Sequence(RandBetween(6, 12)),
        {
            Name: [Generated Name],
            Email: [Generated Email], 
            Phone: [Generated Phone],
            ID: Value
        }
    )
)
```

## 🔧 Configurações Avançadas

### Conectar a Fonte de Dados Real

Para conectar a uma fonte de dados real (SharePoint, SQL, etc.):

1. **Adicione a conexão**:
   ```powerfx
   // Substitua PeopleCollection por sua fonte de dados
   Items = 'Your SharePoint List'
   ```

2. **Configure refresh automático**:
   ```powerfx
   OnTimerEnd = Refresh('Your Data Source'); Set(LastUpdateTime, Now())
   ```

### Adicionar Funcionalidades

#### Busca/Filtro
```powerfx
// Adicionar campo de busca
Filter(PeopleCollection, SearchText in Name || SearchText in Email)
```

#### Ordenação
```powerfx
// Ordenar por nome
Sort(PeopleCollection, Name, SortOrder.Ascending)
```

## 📊 Variáveis Utilizadas

- `AutoRefreshTimer`: Boolean - Controla timer automático
- `LastUpdateTime`: DateTime - Timestamp da última atualização
- `PeopleCollection`: Collection - Dados das pessoas

## 🎯 Boas Práticas

1. **Performance**: Use `ClearCollect` em vez de múltiplos `Patch`
2. **Responsividade**: Configure propriedades de tamanho relativas ao Parent
3. **Acessibilidade**: Adicione `AccessibilityLabel` aos controles
4. **Localization**: Use funções de texto apropriadas para pt-BR

## 🐛 Solução de Problemas

### Timer não funciona
- Verifique se `AutoStart` está definido como `true`
- Confirme que `Duration` está em milissegundos (10000 = 10s)

### Dados não aparecem
- Verifique se `PeopleCollection` foi inicializada no `OnVisible`
- Confirme se `Items` da galeria aponta para a collection correta

### Layout quebrado em mobile
- Ajuste propriedades `X`, `Y`, `Width`, `Height` para serem relativas
- Use `Parent.Width` e `Parent.Height` para dimensionamento

## 📝 Licença

Este projeto é de código aberto e pode ser usado livremente para fins educacionais e comerciais.

## 🤝 Contribuições

Contribuições são bem-vindas! Para contribuir:

1. Fork o projeto
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

---

**Transformado de aplicação web para PowerApps mantendo toda funcionalidade original** 🚀