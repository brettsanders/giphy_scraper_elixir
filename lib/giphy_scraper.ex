defmodule GiphyScraper do
  def search() do
    http_get_request_from_giphy()
    |> decode_json_and_return_data_as_map
    |> convert_list_of_maps_to_giphy_image_structs
  end

  defp http_get_request_from_giphy() do
    # 1. Pass Params to HHTPoison (avoid building string)
    # 2. How pass API Key securely
    results =
      HTTPoison.get!(
        "https://api.giphy.com/v1/gifs/search?api_key=ovHtiqdJ5RuVcQBIpYfA1sMU7mCGwSxB&q=cats&limit=25&offset=0&rating=g&lang=en"
      )

    results.body
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
