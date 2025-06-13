defmodule DIDTest do
  use ExUnit.Case
  doctest DID

  test "URL parse" do
    assert DID.url_parse("did:example:123456789abcdefghi") ==
             {:ok,
              %DID.URL{
                method: "example",
                id: "123456789abcdefghi",
                string: "did:example:123456789abcdefghi",
                path: nil,
                query: [],
                fragment: nil
              }}
  end
end
