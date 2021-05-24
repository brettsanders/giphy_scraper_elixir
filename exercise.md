Create an elixir project using `mix new` named "GiphyScraper" and write a simple project that allows you to call `GiphyScraper.search(query)` and returns 25 results in the following format:

[
  %GiphyImage{
    id: "some_id",
    url: "url_to_gif",
    username: "username of creator",
    title: "SomeGif"
  },

  %GiphyImage{
    id: "some_other_id",
    url: "url_to_gif_2",
    username: "username of creator",
    title: "MyGif"
  }
]

I recommend using the HTTPoison module to make the requests and you can find the Giphy endpoint here.

Note: the naming of `GiphyScraper` and `GiphyImage` are up to you to determine.

Make sure you delete the _build and deps folder, and zip up your project in a ".zip" or ".tar.gz" before uploading.

Submit your assignment