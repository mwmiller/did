defmodule DID.Resolve do
  @moduledoc """
  Functions for resolving Decentralized Identifiers (DIDs).
  """

  @doc """
  Resolves a %DID.URL and returns the corresponding DID document.

  As a convenience, this will also accept a string

  """
  def from_url(did_url)

  def from_url(did_url) when is_binary(did_url) do
    case DID.URL.parse(did_url) do
      {:ok, du} -> from_url(du)
      error -> error
    end
  end

  @web_doc "did.json"
  @web_default_path ".well-known"
  def from_url(%DID.URL{method: "web", id: host, path: path}) do
    final_path =
      case path do
        nil -> @web_default_path
        "" -> @web_default_path
        _ -> path
      end

    resolve_uri = "https://#{host}/#{final_path}/#{@web_doc}"

    case :httpc.request(resolve_uri) do
      {:ok, {{_, 200, _}, _headers, json}} when is_binary(json) ->
        {:ok, :json.decode(json)}

      {:ok, {{_, status, _}, _headers, _}} ->
        {:error, "Failed to resolve DID URL: #{status}"}

      {:error, reason} ->
        {:error, "Failed to resolve DID URL: #{reason}"}
    end
  end

  def from_url(%DID.URL{method: m}),
    do: {:error, "DID resolution not implemented for method: #{m}"}

  def from_url(_),
    do: {:error, "Invalid DID URL"}
end
