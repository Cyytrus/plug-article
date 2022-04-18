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
