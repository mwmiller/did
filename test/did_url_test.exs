defmodule DIDURLTest do
  use ExUnit.Case
  doctest DID.URL

  test "core URL examples" do
    assert DID.URL.parse("did:example:123456789abcdefghi") ==
             {:ok, %DID.URL{method: "example", id: "123456789abcdefghi"}}

    assert DID.URL.parse("did:example:123456/path") ==
             {:ok, %DID.URL{method: "example", id: "123456", path: "path"}}

    assert DID.URL.parse("did:example:123456?versionId=1") ==
             {:ok, %DID.URL{method: "example", id: "123456", query: [{"versionId", "1"}]}}

    assert DID.URL.parse("did:example:123#public-key-0") ==
             {:ok, %DID.URL{method: "example", id: "123", fragment: "public-key-0"}}

    assert DID.URL.parse("did:example:123#agent") ==
             {:ok, %DID.URL{method: "example", id: "123", fragment: "agent"}}

    assert DID.URL.parse("did:example:123?service=agent&relativeRef=/credentials#degree") ==
             {:ok,
              %DID.URL{
                method: "example",
                id: "123",
                query: [{"service", "agent"}, {"relativeRef", "/credentials"}],
                fragment: "degree"
              }}

    assert DID.URL.parse("did:example:123?versionTime=2021-05-10T17:00:00Z") ==
             {:ok,
              %DID.URL{
                method: "example",
                id: "123",
                query: [{"versionTime", "2021-05-10T17:00:00Z"}]
              }}

    assert DID.URL.parse("did:example:123?service=files&relativeRef=/resume.pdf") ==
             {:ok,
              %DID.URL{
                method: "example",
                id: "123",
                query: [{"service", "files"}, {"relativeRef", "/resume.pdf"}]
              }}
  end

  test "web URL examples" do
    assert DID.URL.parse("did:web:w3c-ccg.github.io") ==
             {:ok, %DID.URL{method: "web", id: "w3c-ccg.github.io", path: ""}}

    assert DID.URL.parse("did:web:w3c-ccg.github.io:user:alice") ==
             {:ok, %DID.URL{method: "web", id: "w3c-ccg.github.io", path: "user/alice"}}

    assert DID.URL.parse("did:web:example.com%3A3000:user:alice") ==
             {:ok, %DID.URL{method: "web", id: "example.com:3000", path: "user/alice"}}
  end
end
