defmodule DID do
  @moduledoc """
  Functions for working with Decentralized Identifiers (DIDs).

  These are mainly convenience functions for other modules in
  this package. This might make aliasing easier or provide some
  other nicity.
  """

  @doc """
  Parses a DID URL string and returns a `DID.URL` struct.
  """

  def url_parse(did_string) do
    DID.URL.parse(did_string)
  end
end
