defmodule AshRelationsBarePhx.Foo.FooResource do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "foos"
    repo AshRelationsBarePhx.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  relationships do
    has_many :bars, AshRelationsBarePhx.Bar.BarResource do
      api AshRelationsBarePhx.Bar
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  code_interface do
    define_for AshRelationsBarePhx.Foo
    define :create
    define :read
    define :by_id, get_by: [:id], action: :read
    define :update
    define :destroy
  end
end
