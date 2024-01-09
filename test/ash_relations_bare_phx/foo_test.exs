defmodule AshRelationsBarePhx.FooTest do
  alias AshRelationsBarePhx.Foo.FooResource
  use AshRelationsBarePhx.DataCase, async: true
  alias AshRelationsBarePhx.Bar
  alias AshRelationsBarePhx.Foo

  describe "relationships" do
    test "has_many bars" do
      foo1 = Foo.FooResource.create!(%{title: "Foo 1"})
      bar1 = Bar.BarResource.create!(%{title: "Bar 1", foo_resource_id: foo1.id})
      bar1 = Bar.BarResource.create!(%{title: "Bar 2", foo_resource_id: foo1.id})

      assert %FooResource{bars: [bar1, bar2]} = AshRelationsBarePhx.Foo.load!(foo1, :bars)
    end
  end
end
