defmodule App do

  defstruct endpoint: %{:get=>%{}, :put=>%{},:post=>%{},:delete=>%{}}, port: 8080, ip: {127,0,0,1}

  def new(), do: new(8080)

  def new(port) do
    ip = Application.get_env :tcp_server, :ip, {127,0,0,1}
    port = Application.get_env :tcp_server, :port, port
    %App{ip: ip, port: port}
  end

  def get(%App{endpoint: endpoint}=app, pattern, handle) do
      %App{app| endpoint: add_endpoint(endpoint, :get, pattern, handle)}
  end

  def post(%App{endpoint: endpoint}=app, pattern, handle) do
    %App{app| endpoint: add_endpoint(endpoint, :post, pattern, handle)}
  end

  def put(%App{endpoint: endpoint}=app, pattern, handle) do
    %App{app| endpoint: add_endpoint(endpoint, :put, pattern, handle)}
  end


  def delete(%App{endpoint: endpoint}=app, pattern, handle) do
    %App{app| endpoint: add_endpoint(endpoint, :delete, pattern, handle)}
  end

  defp add_endpoint(endpoint, method, pattern, handler) do

        if (pattern_is_ok?(pattern)) do

          get_endpoint = Map.get(endpoint, method)
          get_endpoint = Map.put_new(get_endpoint, pattern, handler)
          Map.replace(endpoint, method, get_endpoint)

        else
           endpoint
        end

  end

  defp pattern_is_ok?(pattern) do
        true
  end


end
