// =============================================================================
// POWER FX FORMULAS PARA O DIRETÓRIO DE PESSOAS
// =============================================================================
// Este arquivo contém todas as fórmulas Power Fx necessárias para implementar
// a funcionalidade da aplicação Diretório de Pessoas no PowerApps

// =============================================================================
// 1. INICIALIZAÇÃO DA APLICAÇÃO (OnVisible da Tela Principal)
// =============================================================================

// Inicializar collection com dados de exemplo
ClearCollect(
    PeopleCollection,
    Table(
        {Name: "Ana Silva", Email: "ana.silva234@outlook.com", Phone: "(11) 98765-4321", ID: 1},
        {Name: "Carlos Santos", Email: "carlos.santos@gmail.com", Phone: "(21) 91234-5678", ID: 2},
        {Name: "Maria Oliveira", Email: "maria.oliveira@hotmail.com", Phone: "(31) 99876-5432", ID: 3},
        {Name: "João Souza", Email: "joao.souza@yahoo.com.br", Phone: "(41) 94567-8901", ID: 4},
        {Name: "Lucia Rodrigues", Email: "lucia.rodrigues@empresa.com.br", Phone: "(51) 93456-7890", ID: 5},
        {Name: "Pedro Ferreira", Email: "pedro.ferreira@outlook.com", Phone: "(61) 92345-6789", ID: 6},
        {Name: "Fernanda Alves", Email: "fernanda.alves@gmail.com", Phone: "(71) 91234-5678", ID: 7},
        {Name: "Roberto Lima", Email: "roberto.lima@hotmail.com", Phone: "(81) 98765-4321", ID: 8}
    )
);

// Definir timestamp inicial
Set(LastUpdateTime, Now());

// Ativar timer de atualização automática
Set(AutoRefreshEnabled, true)

// =============================================================================
// 2. GERAÇÃO DE DADOS ALEATÓRIOS
// =============================================================================

// Fórmula para gerar nome aleatório brasileiro
With(
    {
        _firstNames: ["Ana", "Carlos", "Maria", "João", "Lucia", "Pedro", "Fernanda", "Roberto", "Camila", "Rafael", "Juliana", "André", "Beatriz", "Diego", "Carla", "Marcos", "Isabela", "Felipe", "Amanda", "Rodrigo", "Vanessa", "Bruno", "Priscila", "Thiago", "Renata", "Lucas", "Mônica", "Gabriel", "Patrícia", "Leonardo"],
        _lastNames: ["Silva", "Santos", "Oliveira", "Souza", "Rodrigues", "Ferreira", "Alves", "Pereira", "Lima", "Gomes", "Costa", "Ribeiro", "Martins", "Carvalho", "Almeida", "Lopes", "Soares", "Fernandes", "Vieira", "Barbosa", "Rocha", "Dias", "Monteiro", "Cardoso", "Reis", "Araújo", "Nascimento", "Freitas", "Correia", "Machado"]
    },
    Index(_firstNames, RandBetween(1, CountRows(_firstNames))).Value & " " & 
    Index(_lastNames, RandBetween(1, CountRows(_lastNames))).Value
)

// Fórmula para gerar email baseado no nome
With(
    {
        _domains: ["gmail.com", "hotmail.com", "yahoo.com.br", "outlook.com", "empresa.com.br"],
        _cleanName: Lower(
            Substitute(
                Substitute(
                    Substitute(
                        Substitute(
                            Substitute([GeneratedName], " ", "."),
                            "ã", "a"
                        ),
                        "ç", "c"
                    ),
                    "é", "e"
                ),
                "í", "i"
            )
        )
    },
    _cleanName & RandBetween(100, 999) & "@" & 
    Index(_domains, RandBetween(1, CountRows(_domains))).Value
)

// Fórmula para gerar telefone brasileiro
With(
    {
        _areaCodes: ["11", "21", "31", "41", "51", "61", "71", "81", "85", "87"]
    },
    "(" & Index(_areaCodes, RandBetween(1, CountRows(_areaCodes))).Value & ") " &
    RandBetween(90000, 99999) & "-" & RandBetween(1000, 9999)
)

// =============================================================================
// 3. ATUALIZAÇÃO COMPLETA DOS DADOS (OnSelect do Botão Refresh)
// =============================================================================

// Mostrar indicador de carregamento
Set(IsLoading, true);

// Gerar nova coleção com dados aleatórios
With(
    {
        _firstNames: ["Ana", "Carlos", "Maria", "João", "Lucia", "Pedro", "Fernanda", "Roberto", "Camila", "Rafael", "Juliana", "André", "Beatriz", "Diego", "Carla", "Marcos", "Isabela", "Felipe", "Amanda", "Rodrigo", "Vanessa", "Bruno", "Priscila", "Thiago", "Renata", "Lucas", "Mônica", "Gabriel", "Patrícia", "Leonardo"],
        _lastNames: ["Silva", "Santos", "Oliveira", "Souza", "Rodrigues", "Ferreira", "Alves", "Pereira", "Lima", "Gomes", "Costa", "Ribeiro", "Martins", "Carvalho", "Almeida", "Lopes", "Soares", "Fernandes", "Vieira", "Barbosa", "Rocha", "Dias", "Monteiro", "Cardoso", "Reis", "Araújo", "Nascimento", "Freitas", "Correia", "Machado"],
        _domains: ["gmail.com", "hotmail.com", "yahoo.com.br", "outlook.com", "empresa.com.br"],
        _areaCodes: ["11", "21", "31", "41", "51", "61", "71", "81", "85", "87"]
    },
    ClearCollect(
        PeopleCollection,
        ForAll(
            Sequence(RandBetween(6, 15)),
            With(
                {
                    _firstName: Index(_firstNames, RandBetween(1, CountRows(_firstNames))).Value,
                    _lastName: Index(_lastNames, RandBetween(1, CountRows(_lastNames))).Value,
                    _domain: Index(_domains, RandBetween(1, CountRows(_domains))).Value,
                    _areaCode: Index(_areaCodes, RandBetween(1, CountRows(_areaCodes))).Value,
                    _fullName: Index(_firstNames, RandBetween(1, CountRows(_firstNames))).Value & " " & Index(_lastNames, RandBetween(1, CountRows(_lastNames))).Value
                },
                {
                    Name: _fullName,
                    Email: Lower(
                        Substitute(
                            Substitute(_fullName, " ", "."),
                            "ã", "a"
                        )
                    ) & RandBetween(100, 999) & "@" & _domain,
                    Phone: "(" & _areaCode & ") " & RandBetween(90000, 99999) & "-" & RandBetween(1000, 9999),
                    ID: Value
                }
            )
        )
    )
);

// Atualizar timestamp
Set(LastUpdateTime, Now());

// Esconder indicador de carregamento
Set(IsLoading, false)

// =============================================================================
// 4. TIMER DE ATUALIZAÇÃO AUTOMÁTICA (OnTimerEnd)
// =============================================================================

// Executar atualização automática se habilitada
If(
    AutoRefreshEnabled,
    // Executar a mesma lógica do botão refresh
    [CODIGO_DE_ATUALIZACAO_ACIMA];
    // Resetar o timer para continuar o ciclo
    Reset(AutoRefreshTimer)
)

// =============================================================================
// 5. FORMATAÇÃO DE TEXTO E EXIBIÇÃO
// =============================================================================

// Contador de pessoas para exibição
"Encontradas " & CountRows(PeopleCollection) & " pessoas"

// Formatação de timestamp para exibição
"Última atualização: " & Text(LastUpdateTime, "dd/mm/yyyy hh:mm:ss")

// Status do sistema
If(AutoRefreshEnabled, "🟢 Dados Ativos", "🔴 Parado")

// =============================================================================
// 6. FILTROS E BUSCAS (Para implementação futura)
// =============================================================================

// Filtro por nome (se implementar campo de busca)
Filter(PeopleCollection, SearchBox.Text in Name)

// Ordenação por nome
Sort(PeopleCollection, Name, SortOrder.Ascending)

// Ordenação por email
Sort(PeopleCollection, Email, SortOrder.Ascending)

// =============================================================================
// 7. VARIÁVEIS DE CONTROLE
// =============================================================================

// Variáveis globais necessárias:
// - PeopleCollection: Collection - Dados das pessoas
// - LastUpdateTime: DateTime - Timestamp da última atualização  
// - AutoRefreshEnabled: Boolean - Controla se auto-refresh está ativo
// - IsLoading: Boolean - Controla exibição do indicador de carregamento

// =============================================================================
// 8. CONFIGURAÇÕES DO TIMER
// =============================================================================

// Timer Properties:
// Duration: 10000 (10 segundos)
// AutoStart: true
// Repeat: true
// OnTimerEnd: [CODIGO_TIMER_ACIMA]

// =============================================================================
// 9. PROPRIEDADES DE COR E TEMA
// =============================================================================

// Cores do tema baby pink/blue
// Primary Pink: RGBA(255, 182, 193, 1)
// Primary Blue: RGBA(135, 206, 235, 1)
// Dark Pink: RGBA(255, 145, 164, 1)
// Dark Blue: RGBA(107, 182, 255, 1)
// White: RGBA(255, 255, 255, 1)
// Gray: RGBA(108, 117, 125, 1)
// Dark Gray: RGBA(73, 80, 87, 1)

// Background gradient CSS (para containers que suportam):
"linear-gradient(135deg, #FFC0CB 0%, #ADD8E6 100%)"

// =============================================================================
// 10. ACESSIBILIDADE E LOCALIZAÇÃO
// =============================================================================

// Labels de acessibilidade (AccessibilityLabel properties):
// - PeopleGallery: "Lista de pessoas do diretório"
// - RefreshButton: "Atualizar dados manualmente"
// - AutoRefreshTimer: "Timer de atualização automática"

// Textos em português brasileiro
// - Use sempre "pessoas" em vez de "users" 
// - Formato de data: dd/mm/yyyy
// - Formato de telefone: (XX) XXXXX-XXXX