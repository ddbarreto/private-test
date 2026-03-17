# Como colocar o Private Payroll no GitHub

Siga estes passos no **Terminal** (e no navegador, no passo 2).

---

## 1. Inicializar o Git e fazer o primeiro commit

No Terminal, rode (um comando por vez ou tudo junto):

```bash
cd ~/private-payroll

git init
git add .
git commit -m "Initial commit: Private Payroll iOS app com contador de pesquisas"
```

---

## 2. Criar o repositório no GitHub

1. Acesse **https://github.com/new**
2. Em **Repository name**, coloque: `private-payroll` (ou outro nome que preferir)
3. Escolha **Private** ou **Public**
4. **Não** marque "Add a README" (o projeto já tem arquivos)
5. Clique em **Create repository**

---

## 3. Conectar e enviar o código

O GitHub vai mostrar comandos. Use estes (troque `SEU_USUARIO` pelo seu usuário do GitHub):

**Se você usa HTTPS:**

```bash
git remote add origin https://github.com/SEU_USUARIO/private-payroll.git
git branch -M main
git push -u origin main
```

**Se você usa SSH:**

```bash
git remote add origin git@github.com:SEU_USUARIO/private-payroll.git
git branch -M main
git push -u origin main
```

Exemplo: se seu usuário for `eduardabarreto`, o endereço fica  
`https://github.com/eduardabarreto/private-payroll.git`

---

## Resumo rápido

| Passo | Comando / Ação |
|-------|-----------------|
| 1 | `cd ~/private-payroll` |
| 2 | `git init` |
| 3 | `git add .` |
| 4 | `git commit -m "Initial commit: Private Payroll iOS app"` |
| 5 | Criar repositório em github.com/new |
| 6 | `git remote add origin https://github.com/SEU_USUARIO/private-payroll.git` |
| 7 | `git branch -M main` |
| 8 | `git push -u origin main` |

Depois disso, o projeto estará no GitHub e você poderá acessá-lo pelo site.
