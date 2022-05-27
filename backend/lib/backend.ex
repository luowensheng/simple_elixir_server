defmodule Backend do

  def hello5() do

      app =  App.new()

      app = App.get(app, "/home", fn (_rw, _res)->
            IO.puts("hello")
      end)

      app = App.post(app, "/home", fn (_rw, _res)->
        IO.puts("home")
      end)

      app = App.delete(app, "/home", fn (_rw, _res)->
        IO.puts("home")
      end)

      app = App.put(app, "/home", fn (_rw, _res)->
        IO.puts("home")
      end)

      app = App.put(app, "/house", fn (_rw, _res)->
        IO.puts("home")
      end)

      TcpServer.start_link()

  end

end

# Backend.start()
# Backend.hello5()
s = "GET / HTTP/1.1\r\nHost: localhost:9099\r\nUser-Agent: curl/7.79.1\r\nAccept: */*\r\n\r\n"
Response.Writer.parse(s)
