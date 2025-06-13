defmodule DIDURLTest do
  use ExUnit.Case
  doctest DID.URL

  test "core URL examples" do
    assert DID.URL.parse("did:example:123456789abcdefghi") ==
             {:ok,
              %DID.URL{
                method: "example",
                id: "123456789abcdefghi",
                string: "did:example:123456789abcdefghi"
              }}

    assert DID.URL.parse("did:example:123456/path") ==
             {:ok,
              %DID.URL{
                method: "example",
                id: "123456",
                path: "path",
                string: "did:example:123456/path"
              }}

    assert DID.URL.parse("did:example:123456?versionId=1") ==
             {:ok,
              %DID.URL{
                method: "example",
                id: "123456",
                query: [{"versionId", "1"}],
                string: "did:example:123456?versionId=1"
              }}

    assert DID.URL.parse("did:example:123#public-key-0") ==
             {:ok,
              %DID.URL{
                method: "example",
                id: "123",
                fragment: "public-key-0",
                string: "did:example:123#public-key-0"
              }}

    assert DID.URL.parse("did:example:123#agent") ==
             {:ok,
              %DID.URL{
                method: "example",
                id: "123",
                fragment: "agent",
                string: "did:example:123#agent"
              }}

    assert DID.URL.parse("did:example:123?service=agent&relativeRef=/credentials#degree") ==
             {:ok,
              %DID.URL{
                method: "example",
                id: "123",
                query: [{"service", "agent"}, {"relativeRef", "/credentials"}],
                fragment: "degree",
                string: "did:example:123?service=agent&relativeRef=/credentials#degree"
              }}

    assert DID.URL.parse("did:example:123?versionTime=2021-05-10T17:00:00Z") ==
             {:ok,
              %DID.URL{
                method: "example",
                id: "123",
                query: [{"versionTime", "2021-05-10T17:00:00Z"}],
                string: "did:example:123?versionTime=2021-05-10T17:00:00Z"
              }}

    assert DID.URL.parse("did:example:123?service=files&relativeRef=/resume.pdf") ==
             {:ok,
              %DID.URL{
                method: "example",
                id: "123",
                query: [{"service", "files"}, {"relativeRef", "/resume.pdf"}],
                string: "did:example:123?service=files&relativeRef=/resume.pdf"
              }}
  end

  test "web URL examples" do
    assert DID.URL.parse("did:web:w3c-ccg.github.io") ==
             {:ok,
              %DID.URL{
                method: "web",
                id: "w3c-ccg.github.io",
                path: "",
                string: "did:web:w3c-ccg.github.io"
              }}

    assert DID.URL.parse("did:web:w3c-ccg.github.io:user:alice") ==
             {:ok,
              %DID.URL{
                method: "web",
                id: "w3c-ccg.github.io",
                path: "user/alice",
                string: "did:web:w3c-ccg.github.io:user:alice"
              }}

    assert DID.URL.parse("did:web:example.com%3A3000:user:alice") ==
             {:ok,
              %DID.URL{
                method: "web",
                id: "example.com:3000",
                path: "user/alice",
                string: "did:web:example.com%3A3000:user:alice"
              }}
  end
end
