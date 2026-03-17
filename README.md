# Private Payroll

App iOS em SwiftUI que **conta quantas pesquisas foram feitas** no contexto de folha de pagamento privada.

## O que o app faz

- **Campo de pesquisa**: digite um termo relacionado a folha de pagamento e toque em **Pesquisar**.
- **Contador**: o número de pesquisas realizadas é exibido em destaque e atualizado a cada nova busca.
- **Histórico**: as últimas pesquisas aparecem em lista na tela.

## Como rodar no Simulador iOS (Xcode)

1. **Abra o projeto no Xcode**
   - Abra o Xcode.
   - **File → Open** (ou `Cmd + O`).
   - Navegue até a pasta do repositório e abra o arquivo **`PrivatePayroll.xcodeproj`** (dentro da pasta `PrivatePayroll`).
   - Caminho completo: `private-payroll/PrivatePayroll/PrivatePayroll.xcodeproj`

2. **Selecione um simulador**
   - No topo da janela do Xcode, clique no menu do **scheme** (onde está “Private Payroll”).
   - Em **Destination**, escolha um iPhone de simulador (ex.: **iPhone 16**, **iPhone 15**, etc.).

3. **Rode o app**
   - Pressione **`Cmd + R`** ou clique no botão **Run** (▶️).
   - O app será compilado e aberto no simulador iOS; use o campo de pesquisa e o botão **Pesquisar** para ver o contador subir.

## Estrutura do repositório

```
private-payroll/
├── README.md
└── PrivatePayroll/
    ├── PrivatePayroll.xcodeproj    ← abrir este arquivo no Xcode
    └── PrivatePayroll/
        ├── PrivatePayrollApp.swift
        ├── ContentView.swift
        ├── Info.plist
        └── Assets.xcassets
```

## Requisitos

- Xcode 15+ (recomendado)
- iOS 17.0+
- macOS com suporte ao Simulador iOS

## Próximos passos (opcional)

- Persistir o contador com `UserDefaults` ou Core Data.
- Conectar a uma API ou base de dados real para buscar dados de folha de pagamento.
- Adicionar filtros ou tipos de pesquisa.
