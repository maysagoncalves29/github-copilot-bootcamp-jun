MainScreen As appinfo:
    BackColor = RGBA(255, 182, 193, 1)
    Fill = 
        With(
            {
                _gradient: 
                    "data:image/svg+xml," & 
                    EncodeUrl(
                        "<svg xmlns='http://www.w3.org/2000/svg' width='100%' height='100%'>" &
                        "<defs>" &
                        "<linearGradient id='grad' x1='0%' y1='0%' x2='100%' y2='100%'>" &
                        "<stop offset='0%' stop-color='#FFC0CB'/>" &
                        "<stop offset='100%' stop-color='#ADD8E6'/>" &
                        "</linearGradient>" &
                        "</defs>" &
                        "<rect width='100%' height='100%' fill='url(#grad)'/>" &
                        "</svg>"
                    )
            },
            _gradient
        )
    LoadingSpinner = LoadingSpinner1.Visible
    LoadingSpinnerColor = RGBA(255, 182, 193, 1)
    OnVisible = 
        // Initialize the people collection with sample data
        ClearCollect(
            PeopleCollection,
            Table(
                {
                    Name: "Ana Silva",
                    Email: "ana.silva234@outlook.com", 
                    Phone: "(11) 98765-4321",
                    ID: 1
                },
                {
                    Name: "Carlos Santos",
                    Email: "carlos.santos@gmail.com",
                    Phone: "(21) 91234-5678", 
                    ID: 2
                },
                {
                    Name: "Maria Oliveira",
                    Email: "maria.oliveira@hotmail.com",
                    Phone: "(31) 99876-5432",
                    ID: 3
                },
                {
                    Name: "João Souza",
                    Email: "joao.souza@yahoo.com.br",
                    Phone: "(41) 94567-8901",
                    ID: 4
                },
                {
                    Name: "Lucia Rodrigues", 
                    Email: "lucia.rodrigues@empresa.com.br",
                    Phone: "(51) 93456-7890",
                    ID: 5
                },
                {
                    Name: "Pedro Ferreira",
                    Email: "pedro.ferreira@outlook.com",
                    Phone: "(61) 92345-6789",
                    ID: 6
                },
                {
                    Name: "Fernanda Alves",
                    Email: "fernanda.alves@gmail.com", 
                    Phone: "(71) 91234-5678",
                    ID: 7
                },
                {
                    Name: "Roberto Lima",
                    Email: "roberto.lima@hotmail.com",
                    Phone: "(81) 98765-4321",
                    ID: 8
                }
            )
        );
        // Set up timer for auto-refresh
        Set(AutoRefreshTimer, true);
        Set(LastUpdateTime, Now())

    =HeaderContainer As groupContainer:
        X = 20
        Y = 20
        Width = Parent.Width - 40
        Height = 140
        Fill = RGBA(255, 255, 255, 1)
        BorderRadius = 20
        DropShadow = DropShadow.Regular

        =TitleLabel As label:
            Text = "🔍 Diretório de Pessoas"
            X = 20
            Y = 20
            Width = Parent.Width - 40
            Height = 60
            Size = 24
            FontWeight = FontWeight.Bold
            Color = RGBA(255, 145, 164, 1)
            Align = Align.Center

        =SubtitleLabel As label:
            Text = "Resultados da Pesquisa API"
            X = 20
            Y = 80
            Width = Parent.Width - 40
            Height = 40
            Size = 16
            Color = RGBA(108, 117, 125, 1)
            Align = Align.Center

    =StatusContainer As groupContainer:
        X = 20
        Y = HeaderContainer.Y + HeaderContainer.Height + 20
        Width = Parent.Width - 40
        Height = 60
        Fill = RGBA(255, 255, 255, 1)
        BorderRadius = 15
        DropShadow = DropShadow.Light

        =StatusIndicator As circle:
            X = 20
            Y = (Parent.Height - 12) / 2
            Width = 12
            Height = 12
            Fill = RGBA(135, 206, 235, 1)
            BorderThickness = 0

        =StatusLabel As label:
            Text = "Dados Ativos"
            X = StatusIndicator.X + StatusIndicator.Width + 10
            Y = (Parent.Height - 30) / 2
            Width = 100
            Height = 30
            Size = 14
            FontWeight = FontWeight.Semibold
            Color = RGBA(73, 80, 87, 1)

        =LastUpdateLabel As label:
            Text = "Última atualização: " & Text(LastUpdateTime, "dd/mm/yyyy hh:mm:ss")
            X = Parent.Width - 250
            Y = (Parent.Height - 30) / 2
            Width = 230
            Height = 30
            Size = 12
            Color = RGBA(108, 117, 125, 1)
            Align = Align.Right

    =ResultsContainer As groupContainer:
        X = 20
        Y = StatusContainer.Y + StatusContainer.Height + 20
        Width = Parent.Width - 40
        Height = Parent.Height - Y - 40
        Fill = RGBA(255, 255, 255, 1)
        BorderRadius = 20
        DropShadow = DropShadow.Regular

        =ResultsHeader As groupContainer:
            X = 0
            Y = 0
            Width = Parent.Width
            Height = 70
            Fill = 
                With(
                    {
                        _gradient: 
                            "data:image/svg+xml," & 
                            EncodeUrl(
                                "<svg xmlns='http://www.w3.org/2000/svg' width='100%' height='100%'>" &
                                "<defs>" &
                                "<linearGradient id='headerGrad' x1='0%' y1='0%' x2='100%' y2='0%'>" &
                                "<stop offset='0%' stop-color='#FFB6C1'/>" &
                                "<stop offset='100%' stop-color='#87CEEB'/>" &
                                "</linearGradient>" &
                                "</defs>" &
                                "<rect width='100%' height='100%' fill='url(#headerGrad)'/>" &
                                "</svg>"
                            )
                    },
                    _gradient
                )
            BorderRadius = 20

            =ResultsTitle As label:
                Text = "Resultados da Pesquisa"
                X = 20
                Y = (Parent.Height - 30) / 2
                Width = 300
                Height = 30
                Size = 18
                FontWeight = FontWeight.Semibold
                Color = RGBA(255, 255, 255, 1)

            =ResultsCount As label:
                Text = CountRows(PeopleCollection) & " pessoas encontradas"
                X = Parent.Width - 200
                Y = (Parent.Height - 30) / 2
                Width = 180
                Height = 30
                Size = 14
                FontWeight = FontWeight.Medium
                Color = RGBA(255, 255, 255, 1)
                Align = Align.Right

        =PeopleGallery As gallery:
            Items = PeopleCollection
            X = 20
            Y = ResultsHeader.Height + 10
            Width = Parent.Width - 40
            Height = Parent.Height - ResultsHeader.Height - 30
            BorderThickness = 0
            ShowScrollbar = true
            TemplatePadding = 5
            TemplateSize = 60

            =NameLabel As label:
                Text = ThisItem.Name
                X = 10
                Y = 5
                Width = 150
                Height = 25
                Size = 14
                FontWeight = FontWeight.Semibold
                Color = RGBA(73, 80, 87, 1)

            =EmailLabel As label:
                Text = ThisItem.Email
                X = 170
                Y = 5
                Width = 200
                Height = 25
                Size = 12
                Color = RGBA(107, 182, 255, 1)

            =PhoneLabel As label:
                Text = ThisItem.Phone
                X = 10
                Y = 30
                Width = 150
                Height = 25
                Size = 12
                Color = RGBA(255, 145, 164, 1)

    =RefreshButton As button:
        Text = "🔄 Atualizar Dados"
        X = 20
        Y = Parent.Height - 80
        Width = 200
        Height = 50
        Fill = RGBA(135, 206, 235, 1)
        Color = RGBA(255, 255, 255, 1)
        BorderThickness = 0
        BorderRadius = 25
        FontWeight = FontWeight.Semibold
        OnSelect = 
            // Simulate data refresh with some changes
            With(
                {
                    _firstNames: ["Ana", "Carlos", "Maria", "João", "Lucia", "Pedro", "Fernanda", "Roberto", "Camila", "Rafael"],
                    _lastNames: ["Silva", "Santos", "Oliveira", "Souza", "Rodrigues", "Ferreira", "Alves", "Pereira", "Lima", "Gomes"],
                    _domains: ["gmail.com", "hotmail.com", "yahoo.com.br", "outlook.com", "empresa.com.br"],
                    _areaCodes: ["11", "21", "31", "41", "51", "61", "71", "81", "85", "87"]
                },
                ClearCollect(
                    PeopleCollection,
                    ForAll(
                        Sequence(RandBetween(6, 12)),
                        With(
                            {
                                _firstName: Index(_firstNames, RandBetween(1, CountRows(_firstNames))).Value,
                                _lastName: Index(_lastNames, RandBetween(1, CountRows(_lastNames))).Value,
                                _domain: Index(_domains, RandBetween(1, CountRows(_domains))).Value,
                                _areaCode: Index(_areaCodes, RandBetween(1, CountRows(_areaCodes))).Value
                            },
                            {
                                Name: _firstName & " " & _lastName,
                                Email: Lower(_firstName & "." & _lastName & RandBetween(100, 999) & "@" & _domain),
                                Phone: "(" & _areaCode & ") " & RandBetween(10000, 99999) & "-" & RandBetween(1000, 9999),
                                ID: Value
                            }
                        )
                    )
                )
            );
            Set(LastUpdateTime, Now())

    =AutoRefreshTimer As timer:
        Duration = 10000  // 10 seconds
        Repeat = true
        AutoStart = true
        OnTimerEnd = 
            RefreshButton.OnSelect;
            Reset(AutoRefreshTimer)

    =LoadingSpinner1 As loadingSpinner:
        X = (Parent.Width - 100) / 2
        Y = (Parent.Height - 100) / 2
        Width = 100
        Height = 100
        Visible = false
        Color = RGBA(255, 182, 193, 1)