defmodule GiphyImage do
  @enforce_keys [:id, :url, :username, :title]
  defstruct [
    :id,
    :url,
    :username,
    :title
  ]
end
