defmodule DIDTest do
  use ExUnit.Case
  doctest DID

  test "core URL examples" do
    assert DID.from_url("did:example:123456789abcdefghi") ==
             {:ok, %DID{method: "example", id: "123456789abcdefghi"}}

    assert DID.from_url("did:example:123456/path") ==
             {:ok, %DID{method: "example", id: "123456", path: "path"}}

    assert DID.from_url("did:example:123456?versionId=1") ==
             {:ok, %DID{method: "example", id: "123456", query: [{"versionId", "1"}]}}

    assert DID.from_url("did:example:123#public-key-0") ==
             {:ok, %DID{method: "example", id: "123", fragment: "public-key-0"}}

    assert DID.from_url("did:example:123#agent") ==
             {:ok, %DID{method: "example", id: "123", fragment: "agent"}}

    assert DID.from_url("did:example:123?service=agent&relativeRef=/credentials#degree") ==
             {:ok,
              %DID{
                method: "example",
                id: "123",
                query: [{"service", "agent"}, {"relativeRef", "/credentials"}],
                fragment: "degree"
              }}

    assert DID.from_url("did:example:123?versionTime=2021-05-10T17:00:00Z") ==
             {:ok,
              %DID{
                method: "example",
                id: "123",
                query: [{"versionTime", "2021-05-10T17:00:00Z"}]
              }}

    assert DID.from_url("did:example:123?service=files&relativeRef=/resume.pdf") ==
             {:ok,
              %DID{
                method: "example",
                id: "123",
                query: [{"service", "files"}, {"relativeRef", "/resume.pdf"}]
              }}
  end
end
