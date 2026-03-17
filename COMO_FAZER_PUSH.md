# Como fazer o push para o GitHub (quando pede senha e não funciona)

O Git já está configurado e o commit existe. Só falta o **push** funcionar. O GitHub não aceita mais sua senha normal no Terminal — você precisa de um **Personal Access Token**.

---

## Passo 1: Criar um Personal Access Token no GitHub

1. Entre no GitHub e clique na sua **foto** (canto superior direito) → **Settings**.
2. No menu da esquerda, vá até o final e clique em **Developer settings**.
3. Clique em **Personal access tokens** → **Tokens (classic)**.
4. Clique em **Generate new token** → **Generate new token (classic)**.
5. Dê um nome (ex.: `Mac Terminal`) e marque o escopo **repo** (acesso a repositórios).
6. Clique em **Generate token**.
7. **Copie o token** e guarde em um lugar seguro — ele só aparece uma vez.  
   (Parece algo como: `ghp_xxxxxxxxxxxxxxxxxxxx`)

---

## Passo 2: Fazer o push no Terminal

Abra o **Terminal** (fora do Cursor) e rode:

```bash
cd ~/private-payroll
git push -u origin main
```

Quando pedir:

- **Username:** seu usuário do GitHub (ex.: `ddbarreto`)
- **Password:** **cole o token** que você criou (não use a senha da sua conta)

O push deve concluir e o código vai aparecer em:  
**https://github.com/ddbarreto/private-payroll**

---

## Opção: Salvar a senha para não digitar sempre

Para o Git lembrar o token no Mac:

```bash
git config --global credential.helper osxkeychain
```

Na próxima vez que fizer `git push`, ele pede usuário e token de novo; depois disso o Keychain guarda e não pede de novo.

---

## Se o repositório ainda não existir no GitHub

Se você ainda **não criou** o repositório `private-payroll` na conta **ddbarreto**:

1. Acesse **https://github.com/new**
2. Repository name: **private-payroll**
3. Escolha **Private** ou **Public**
4. **Não** marque "Add a README"
5. Clique em **Create repository**
6. Depois rode no Terminal: `git push -u origin main` (e use o token como senha quando pedir)
