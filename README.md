# http-response
Apache HTTP response captured by PHP

Em conjunto com o APACHE, personaliza as mensagens de reposta do servidor HTTP Apache. 
Cria-se um ALIAS no APACHE para o local onde o sistema de erros PHP vai
atender, por exemplo: Alias /http-response "/usr/share/php/Classes/http-response". 
Depois é necessario configurar o APACHE para que alguns codigos de 
resposta HTTP sejam controlados pela classe. Por exemplo: ErrorDocument 400 /http-response
No exemplo, o erro 404 sera controlado por esta classe. Basta inserir uma linha
dessas no arquivo de configuração do APACHE para cada erro que sera controlado.

Codigos de erro a incluir na conf. do Apache:

    ErrorDocument 301 /http-response
    ErrorDocument 400 /http-response
    ErrorDocument 401 /http-response
    ErrorDocument 403 /http-response
    ErrorDocument 404 /http-response
    ErrorDocument 405 /http-response
    ErrorDocument 406 /http-response
    ErrorDocument 407 /http-response
    ErrorDocument 408 /http-response
    ErrorDocument 409 /http-response
    ErrorDocument 410 /http-response
    ErrorDocument 411 /http-response
    ErrorDocument 412 /http-response
    ErrorDocument 413 /http-response
    ErrorDocument 414 /http-response
    ErrorDocument 416 /http-response
    ErrorDocument 417 /http-response
    ErrorDocument 500 /http-response
    ErrorDocument 501 /http-response
    ErrorDocument 502 /http-response
    ErrorDocument 503 /http-response
    ErrorDocument 504 /http-response
    ErrorDocument 505 /http-response