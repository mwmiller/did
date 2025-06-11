defmodule DID do
  @moduledoc """
  Decentralized Identifier (DID) module.
  """
  defstruct method: nil, id: nil, path: nil, query: [], fragment: nil

  @doc """
  Parses a DID URL and returns a DID struct.

  ## Examples

      iex> DID.from_url("did:example:123456789abcdefghi#fragment")
      {:ok, %DID{method: "example", id: "123456789abcdefghi", path: nil, query: [], fragment: "fragment"}}

      iex> DID.from_url("did:example:123456789abcdefghi?query=param#fragment")
      {:ok, %DID{method: "example", id: "123456789abcdefghi", path: nil, query: [{"query", "param"}], fragment: "fragment"}}

      iex> DID.from_url("invalid-url")
      {:error, "Invalid DID URI"}
  """
  def from_url(url) do
    case URI.parse(url) do
      %URI{scheme: "did", path: urlpath, query: urlquery, fragment: urlfragment} ->
        parse_did(urlpath, urlquery, urlfragment)

      _ ->
        {:error, "Invalid DID URI"}
    end
  end

  defp parse_did(path, query, fragment) do
    case String.split(path, ":") do
      [method, id_path] ->
        [id | path_part] = String.split(id_path, "/")

        path =
          case path_part do
            [] -> nil
            bits -> Enum.join(bits, "/")
          end

        did = %__MODULE__{
          method: method,
          id: id,
          path: path,
          query: parse_query(query),
          fragment: fragment
        }

        {:ok, did}

      _ ->
        {:error, "Invalid DID format"}
    end
  end

  defp parse_query(nil), do: []

  defp parse_query(query) do
    query |> URI.decode_query() |> Enum.to_list() |> Enum.reverse()
  end
end
