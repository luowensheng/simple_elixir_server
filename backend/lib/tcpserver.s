#https://medium.com/blackode/quick-easy-tcp-genserver-with-elixir-and-erlang-10189b25e221
defmodule TcpServer do
  use GenServer

  def start_link(%App{}=app) do
    IO.puts("server started...")
    GenServer.start_link(__MODULE__,[app],[])
  end

  @impl true
  def init [%App{endpoint: _endpoint, ip: ip, port: port}] do

    IO.puts("server started on http://localhost:#{port}")
    {:ok,listen_socket}= :gen_tcp.listen(port,[:binary,{:packet, 0},{:active,true},{:ip,ip}])
    {:ok,socket } = :gen_tcp.accept listen_socket
    {:ok, %{ip: ip, port: port, socket: socket}}
  end

  @impl true
  def handle_info({:tcp, socket, packet}, state) do
    # IO.inspect packet, label: "incoming packet"
    _= Response.Writer.parse(packet)
    :gen_tcp.send socket,"HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n\r\n<html><head><title>Example</title></head><body><p>Worked!!!</p></body></html>"
    # :gen_tcp.send socket,"HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n\r\n#{packet}"
    {:noreply,state}
  end

  @impl true
  def handle_info({:tcp_closed,_socket},state) do
    IO.inspect "Socket has been closed"
    {:noreply,state}
  end

  @impl true
  def handle_info({:tcp_error, socket, reason}, state) do
    IO.inspect socket,label: "connection closed dut to #{reason}"
    {:noreply,state}
  end


end
