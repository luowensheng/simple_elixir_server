#https://medium.com/blackode/quick-easy-tcp-genserver-with-elixir-and-erlang-10189b25e221
defmodule TcpServer do
  use GenServer
  defstruct name: "Sean", roles: []


  def start_link() do
    ip = Application.get_env :tcp_server, :ip, {127,0,0,1}
    port = Application.get_env :tcp_server, :port, 9099

    IO.puts("server started at http://localhost:#{port}")
    GenServer.start_link(__MODULE__,[ip,port],[])
  end

  @impl true
  def init [ip,port] do
    {:ok,listen_socket}= :gen_tcp.listen(port,[:binary,{:packet, 0},{:active,true},{:ip,ip}])
    {:ok,socket } = :gen_tcp.accept listen_socket
    {:ok, %{ip: ip,port: port,socket: socket}}
  end

  @impl true
  def handle_info({:tcp,socket,packet},state) do
    IO.inspect packet, label: "incoming packet"
    :gen_tcp.send socket,"HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n\r\n<html><head><title>Example</title></head><body><p>Worked!!!</p></body></html>"
    {:noreply,state}
  end

  @impl true
  def handle_info({:tcp_closed,_socket},state) do
    IO.inspect "Socket has been closed"
    {:noreply,state}
  end

  @impl true
  def handle_info({:tcp_error,socket,reason},state) do
    IO.inspect socket,label: "connection closed dut to #{reason}"
    {:noreply,state}
  end

  def new() do
   %{:get=>[], :put=>[],:post=>[],:delele=>[]}
  end

  def left <|> right do
    IO.puts("#{left} <|> #{right}")
  end

end
