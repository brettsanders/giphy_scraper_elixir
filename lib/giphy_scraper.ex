defmodule GiphyScraper do
  def search(query_string \\ "programmer") do
    http_get_request_from_giphy(query_string)
    |> decode_json_and_return_data_as_map
    |> convert_list_of_maps_to_giphy_image_structs
  end

  defp http_get_request_from_giphy(query_string) do
    options = [
      params: [
        api_key: "ovHtiqdJ5RuVcQBIpYfA1sMU7mCGwSxB",
        q: query_string,
        limit: 25,
        offset: 0
      ]
    ]

    {:ok, %HTTPoison.Response{body: b}} =
      HTTPoison.request(
        :get,
        "https://api.giphy.com/v1/gifs/search",
        [],
        [],
        options
      )

    b
  end

  defp decode_json_and_return_data_as_map(json) do
    Jason.decode!(json)["data"]
  end

  defp convert_list_of_maps_to_giphy_image_structs(data) do
    Enum.map(data, fn single_result ->
      %GiphyImage{
        id: single_result["id"],
        url: single_result["url"],
        username: single_result["username"],
        title: single_result["title"]
      }
    end)
  end
end
