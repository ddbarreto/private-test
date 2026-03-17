# Configurar o Glean no Private Payroll

Todo o conteúdo de pesquisa do app vem do **Glean** (conhecimento da empresa). Para funcionar, é preciso configurar o instance e o token de API.

## 1. Dados necessários

- **GLEAN_INSTANCE**: identificador da instância Glean da sua empresa (ex.: `minhaempresa`). A URL base fica `https://minhaempresa-be.glean.com`.
- **GLEAN_API_TOKEN**: token de API (Bearer). Pode ser obtido no admin do Glean ou via fluxo OAuth.

Onde achar o instance: no Glean, em **Admin** → **About Glean**.

## 2. Onde configurar no app

No Xcode:

1. Abra o projeto **Private Payroll**.
2. No Project Navigator, clique em **PrivatePayroll** (o target do app).
3. Abra a aba **Info** (ou edite o arquivo `PrivatePayroll/Info.plist`).
4. Adicione duas chaves (se ainda não existirem):
   - **GLEAN_INSTANCE** (String): o instance (ex.: `minhaempresa`).
   - **GLEAN_API_TOKEN** (String): o token de API.

**Importante:** não faça commit do token no repositório. Use variáveis de ambiente no Xcode (Scheme → Run → Arguments / Environment) ou um arquivo `.xcconfig` que fique no `.gitignore`.

## 3. Autenticação (referência)

- Para apps que o usuário usa (como este), o Glean recomenda **OAuth** com o IdP da empresa.
- Para testes ou integrações server-side, dá para usar **Glean-issued tokens**.

Documentação: [Glean Developer – Authentication](https://developers.glean.com/api-info/client/getting-started/authentication).

## 4. Comportamento no app

- Se **GLEAN_INSTANCE** ou **GLEAN_API_TOKEN** estiverem vazios, o app mostra a mensagem *"Glean não configurado"* e nenhum resultado do Glean.
- Ao pesquisar, o app chama a **Search API** do Glean (`POST /rest/api/v1/search`) e exibe os resultados na seção **"Resultados do Glean"**.
- O contador **"Pesquisas realizadas"** continua contando quantas pesquisas você fez no app (local).
