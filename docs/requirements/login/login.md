# RemoteAuthentication Use Case


> ## Casos de sucesso
1. Sistema válida os dados de entrade (email e senha).
2. Sistema faz uma requisição para a URL da API de login.
3. Sistema válida os dados recebidos da API.
4. Sistema entrega os dados da conta do usuário.


> ## Execeção - URL invalida.
1. Sistema retorna uma mensagem de erro inesperado.

> ## Exceção - Dados inválidos
1. Sistema retorna uma mensagem de erro inesperado.
  
> ## Exceção - Resposta inválida
1. Sistema retorna uma mensagem de eror inesperado.

> ## Exceção - Crendenciais inválidas
1. Sistema retorna uma mensagem de erro informando que as credenciais estão erradas.


#### Regras Validação.

1. Os campos devem começar sem exibir mensagem de erro.
2. O botão de fazer login deve começar desabilitado.
3. Após digitar algo em um campo, a mensagem de erro deve sumir se o campo for válido.
4. Validar email quando uusário digitar o campo.
5. Mostrar mensagem de erro se o email for inválido.
6. Remover mensagem de erro se o email for inválido.
7. Validar senha quando o usuário digitar no campo.
8. Mostrar mensagem de erro se a senha for inválida.
9. Remover mensagem de erro sa senha for válida.
10. Habilitar o botão de fazer login se todos os campos forem válidos.
11. Desabilitar o botão de login se algum campo for inválido.
12. Exibir loading no inicio da ação de login.
13. Autenticar usuário com email e senha informados no formulário.
14. Exibir mensagem de erro caso o login falhe.
15. Gravar o token usuário no cache para mantê-lo conectado.
16. Redirecionar o usuário para tela de lista de enquetes.
17. Esconder o loading no fim da ação de login.