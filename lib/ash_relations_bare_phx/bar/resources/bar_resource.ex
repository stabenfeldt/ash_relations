defmodule AshRelationsBarePhx.Bar.BarResource do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "bars"
    repo AshRelationsBarePhx.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  relationships do
    belongs_to :foo, AshRelationsBarePhx.Foo.FooResource do
      api AshRelationsBarePhx.Foo
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string

    attribute :foo_resource_id, :uuid

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  code_interface do
    define_for AshRelationsBarePhx.Bar
    define :create
    define :read
    define :by_id, get_by: [:id], action: :read
    define :update
    define :destroy
  end
end
