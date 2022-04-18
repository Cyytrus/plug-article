# Resumo

Esse repositório tem como intenção mostrar os passos da criação de um Plug em Elixir, a explicação sobre o que são Plugs está no meu [dev.to](https://dev.to/cyytrus/entendendo-plugs-em-elixir-469c)

## Primeiro passo:

Criar o projeto com o comando do mix:

    $ mix new plug_example

após isso, deve-se entrar no diretório por meio do comando

    $ cd plug_example

dentro do projeto, é necessário inserir a lib [plugcowboy](https://github.com/elixir-plug/plug_cowboy) que será responsável por gerenciar nosso servidor web

```Elixir
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:plug_cowboy, "~> 2.0"}
    ]
  end
```
feito isso, é necessário rodar o comando

    $ mix deps.get

para instalar as dependencias da lib

## Segundo passo

Agora que instalamos as dependências necessárias, precisaremos modificar nossa pasta `./lib/plug_example.ex`, escrevendo nosso Plug

```Elixir
defmodule PlugExample do
  import Plug.Conn

  def init(opts) do
    Map.put(opts, :my_option, "We are")
  end

  def call(conn, opts) do
    IO.puts("""
    Verb: #{inspect(conn.method)}
    Host: #{inspect(conn.host)}
    Headers: #{inspect(conn.req_headers)}
    """)

    send_resp(conn, 200, "#{opts[:my_option]} He4rtDevs <3")
  end
end

```

### Explicando o código:

Dentro do nosso módulo `PlugExample`, importamos o a o módulo Plug.Conn da nossa lib `plugcowboy`, que ficará responsável por gerenciar nosso servidor web e informações necessárias.

Após isso, é necessária a criação da função *init/1*, que ficará responsável pela coleta das nossas options que serão utilizadas pela função posterior *call/2*.

Na função *call/2*, serão passados os parâmetros da connection e as options anteriormente coletadas pela função *init/1*, juntamente, será escrito na tela assim que solicitado o verbo da requisição, assim como o host e as headers da requisição.

Após tudo isso, sera retornada uma resposta por meio do pattern matching com a connection, a resposta HTTP (esperado um 200 (OK)), juntamente com as opções antes coletadas em *init/1*

## Terceira parte,

Para executar o programa e ver se o mesmo foi feito corretamente, é necessária a compilação por meio do comando

    $ iex -S mix

Após isso, deve-se escrever no terminal do ***iex*** a seguinte linha

    $ iex(1)> Plug.Adapters.Cowboy.http(PlugExample, %{})

A resposta esperada deve ser algo do tipo:

    {:ok, #PID<0.260.0>}

Após essa resposta, é necessário acessar o host: localhost:4000 para obtermos a nossa escrita com as informações da requisição:

<p align="center">
    <img src="images/Screenshot from 2022-04-18 11-57-44.png">
</p>

E no nosso localhost:4000, teremos a visualização de tudo!

<p align="center">
    <img src="images/Screenshot from 2022-04-18 10-14-14.png">
</p>

Dessa forma, finalizamos a criação do nosso simples porém introdutório e maravilhoso, Plug <3