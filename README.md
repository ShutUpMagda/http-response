# http-response
Apache HTTP response captured by PHP

Em conjunto com o APACHE, personaliza as mensagens de reposta do servidor HTTP Apache. 
Cria-se um ALIAS no APACHE para o local onde o sistema de erros PHP vai
atender, por exemplo: Alias /http-response "/usr/share/php/Classes/http-response". 
Depois é necessario configurar o APACHE para que alguns codigos de 
resposta HTTP sejam controlados pela classe. Por exemplo: ErrorDocument 400 /http-response
No exemplo, o erro 404 sera controlado por esta classe. Basta inserir uma linha
dessas no arquivo de configuração do APACHE para cada erro que sera controlado.