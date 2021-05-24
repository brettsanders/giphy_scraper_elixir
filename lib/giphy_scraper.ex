defmodule GiphyScraper do
  def search(query) do
    HTTPoison.get!(
      "https://api.giphy.com/v1/gifs/search?api_key=ovHtiqdJ5RuVcQBIpYfA1sMU7mCGwSxB&q=cats&limit=25&offset=0&rating=g&lang=en"
    )

    # query
    # |> get_results_from_giphy
    # |> serialize_results_to_list_of_structs
  end
end
