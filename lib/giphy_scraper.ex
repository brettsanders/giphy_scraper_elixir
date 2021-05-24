defmodule GiphyScraper do
  # @spec search(any) :: %{
  #         :__struct__ => HTTPoison.AsyncResponse | HTTPoison.Response,
  #         optional(:body) => any,
  #         optional(:headers) => list,
  #         optional(:id) => reference,
  #         optional(:request) => HTTPoison.Request.t(),
  #         optional(:request_url) => any,
  #         optional(:status_code) => integer
  #       }
  # [
  #   %GiphyImage{
  #     id: "some_id",
  #     url: "url_to_gif",
  #     username: "username of creator",
  #     title: "SomeGif"
  #   },

  #   %GiphyImage{
  #     id: "some_other_id",
  #     url: "url_to_gif_2",
  #     username: "username of creator",
  #     title: "MyGif"
  #   }
  # ]
  def search(query) do
    # 1. Pass Params to HHTPoison (avoid building string)
    # 2. How pass API Key securely
    results =
      HTTPoison.get!(
        "https://api.giphy.com/v1/gifs/search?api_key=ovHtiqdJ5RuVcQBIpYfA1sMU7mCGwSxB&q=cats&limit=25&offset=0&rating=g&lang=en"
      )

    body_json = results.body
    body = Jason.decode!(body_json)
    data = body["data"]

    Enum.map(data, fn single_result ->
      %GiphyImage{
        id: single_result["id"],
        url: single_result["url"],
        username: single_result["username"],
        title: single_result["title"]
      }
    end)

    # query
    # |> get_results_from_giphy
    # |> serialize_results_to_list_of_structs
    # iex(10)> g = %GiphyImage{id: 42, url: "foo.com", username: "amazing", title: "title"}
  end
end
