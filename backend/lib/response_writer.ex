defmodule Response.Writer do

  def parse([h, _t]) do
      IO.puts("PUKE #{h}")
  end

  def parse(packet) do
      packetStr = String.split("#{packet}", "\n")
      parse(packetStr)
  end


end
