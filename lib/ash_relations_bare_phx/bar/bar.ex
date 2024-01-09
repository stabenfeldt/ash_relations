defmodule AshRelationsBarePhx.Bar do
  use Ash.Api,
    extensions: [AshAdmin.Api]

  admin do
    show? true
  end

  resources do
    resource AshRelationsBarePhx.Bar.BarResource
  end
end
