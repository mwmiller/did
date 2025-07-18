defmodule DID.URL do
  @moduledoc """
  Decentralized Identifier (DID) module.
  """
  defstruct method: nil, id: nil, path: nil, query: [], fragment: nil, string: ""

  @doc """
  Parses a DID URL and returns a DID.URL struct.

  ## Examples

      iex> DID.URL.parse("did:example:123456789abcdefghi#fragment")
      {:ok, %DID.URL{method: "example", id: "123456789abcdefghi", path: nil, query: [], fragment: "fragment", string: "did:example:123456789abcdefghi#fragment"}}

      iex> DID.URL.parse("did:example:123456789abcdefghi?query=param#fragment")
      {:ok, %DID.URL{method: "example", id: "123456789abcdefghi", path: nil, query: [{"query", "param"}], fragment: "fragment", string: "did:example:123456789abcdefghi?query=param#fragment"}}

      iex> DID.URL.parse("http://example.com")
      {:error, "Invalid DID URI"}
  """
  def parse(url) do
    case URI.parse(url) do
      %URI{scheme: "did", path: urlpath, query: urlquery, fragment: urlfragment} ->
        parse_did(url, urlpath, urlquery, urlfragment)

      _ ->
        {:error, "Invalid DID URI"}
    end
  end

  defp parse_did(string, path, query, fragment) do
    {method, id, path} =
      case String.split(path, ":") do
        ["web", host | rest] ->
          {"web", String.replace(host, "%3A", ":"), Enum.join(rest, "/")}

        [m, id_path] ->
          [i | path_part] = String.split(id_path, "/")

          p =
            case path_part do
              [] -> nil
              bits -> Enum.join(bits, "/")
            end

          {m, i, p}

        _ ->
          {nil, nil, nil}
      end

    did = %__MODULE__{
      method: method,
      id: id,
      path: path,
      query: parse_query(query),
      fragment: fragment,
      string: string
    }

    {:ok, did}
  end

  defp parse_query(nil), do: []

  defp parse_query(query) do
    query |> URI.decode_query() |> Enum.to_list() |> Enum.reverse()
  end
end
