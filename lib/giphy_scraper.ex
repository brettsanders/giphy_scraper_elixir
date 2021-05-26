defmodule GiphyScraper do
  @spec search(any) :: list
  def search(query_string \\ "programmer") do
    # Use With (possibility of failure)
    # Stub options -- default arg, change function; or use Adapter; use mocking library
    query_string
    |> http_get_request_from_giphy
    |> decode_json_and_return_data_as_map
    |> convert_list_of_maps_to_giphy_image_structs
  end

  defp http_get_request_from_giphy(query_string) do
    options = [
      params: [
        api_key: Application.fetch_env!(:giphy_scraper, :giphy_api_key),
        q: query_string,
        limit: 25,
        offset: 0
      ]
    ]

    # Jason
    # Same as below
    # HTTPoison.get!(
    #        "https://api.giphy.com/v1/gifs/search",
    #        []
    #        options)

    case HTTPoison.request(
           :get,
           "https://api.giphy.com/v1/gifs/search",
           [],
           [],
           options
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
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
