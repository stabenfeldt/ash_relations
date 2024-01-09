defmodule AshRelationsBarePhx.FooTest do
  alias AshRelationsBarePhx.Bar.BarResource
  alias AshRelationsBarePhx.Foo.FooResource
  use AshRelationsBarePhx.DataCase, async: true
  alias AshRelationsBarePhx.Bar
  alias AshRelationsBarePhx.Foo

  describe "relationships" do
    test "has_many bars" do
      foo1 = Foo.FooResource.create!(%{title: "Foo 1"})

      %BarResource{id: bar1id} =
        Bar.BarResource.create!(%{title: "Bar 1", foo_resource_id: foo1.id})

      %BarResource{id: bar2id} =
        Bar.BarResource.create!(%{title: "Bar 2", foo_resource_id: foo1.id})

      assert %FooResource{bars: [%BarResource{id: ^bar1id}, %BarResource{id: ^bar2id}]} =
               AshRelationsBarePhx.Foo.load!(foo1, :bars)
    end
  end
end
