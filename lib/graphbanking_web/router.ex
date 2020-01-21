defmodule GraphbankingWeb.Router do
  use GraphbankingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: GraphbankingWeb.Schema

    forward "/", Absinthe.Plug,
    schema: GraphbankingWeb.Schema
  end
end
