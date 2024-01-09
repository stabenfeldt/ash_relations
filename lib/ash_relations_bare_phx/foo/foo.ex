defmodule AshRelationsBarePhx.Foo do
  use Ash.Api,
    extensions: [AshAdmin.Api]

  admin do
    show? true
  end

  resources do
    resource AshRelationsBarePhx.Foo.FooResource
  end
end
