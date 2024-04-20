defmodule Bakery.IngredientsTest do
  use Bakery.DataCase

  alias Bakery.Ingredients

  describe "flavors" do
    alias Bakery.Ingredients.Flavor

    import Bakery.IngredientsFixtures

    @invalid_attrs %{name: nil}

    test "list_flavors/0 returns all flavors" do
      flavor = flavor_fixture()
      assert Ingredients.list_flavors() == [flavor]
    end

    test "get_flavor!/1 returns the flavor with given id" do
      flavor = flavor_fixture()
      assert Ingredients.get_flavor!(flavor.id) == flavor
    end

    test "create_flavor/1 with valid data creates a flavor" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Flavor{} = flavor} = Ingredients.create_flavor(valid_attrs)
      assert flavor.name == "some name"
    end

    test "create_flavor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ingredients.create_flavor(@invalid_attrs)
    end

    test "update_flavor/2 with valid data updates the flavor" do
      flavor = flavor_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Flavor{} = flavor} = Ingredients.update_flavor(flavor, update_attrs)
      assert flavor.name == "some updated name"
    end

    test "update_flavor/2 with invalid data returns error changeset" do
      flavor = flavor_fixture()
      assert {:error, %Ecto.Changeset{}} = Ingredients.update_flavor(flavor, @invalid_attrs)
      assert flavor == Ingredients.get_flavor!(flavor.id)
    end

    test "delete_flavor/1 deletes the flavor" do
      flavor = flavor_fixture()
      assert {:ok, %Flavor{}} = Ingredients.delete_flavor(flavor)
      assert_raise Ecto.NoResultsError, fn -> Ingredients.get_flavor!(flavor.id) end
    end

    test "change_flavor/1 returns a flavor changeset" do
      flavor = flavor_fixture()
      assert %Ecto.Changeset{} = Ingredients.change_flavor(flavor)
    end
  end

  describe "fillings" do
    alias Bakery.Ingredients.Filling

    import Bakery.IngredientsFixtures

    @invalid_attrs %{name: nil}

    test "list_fillings/0 returns all fillings" do
      filling = filling_fixture()
      assert Ingredients.list_fillings() == [filling]
    end

    test "get_filling!/1 returns the filling with given id" do
      filling = filling_fixture()
      assert Ingredients.get_filling!(filling.id) == filling
    end

    test "create_filling/1 with valid data creates a filling" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Filling{} = filling} = Ingredients.create_filling(valid_attrs)
      assert filling.name == "some name"
    end

    test "create_filling/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ingredients.create_filling(@invalid_attrs)
    end

    test "update_filling/2 with valid data updates the filling" do
      filling = filling_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Filling{} = filling} = Ingredients.update_filling(filling, update_attrs)
      assert filling.name == "some updated name"
    end

    test "update_filling/2 with invalid data returns error changeset" do
      filling = filling_fixture()
      assert {:error, %Ecto.Changeset{}} = Ingredients.update_filling(filling, @invalid_attrs)
      assert filling == Ingredients.get_filling!(filling.id)
    end

    test "delete_filling/1 deletes the filling" do
      filling = filling_fixture()
      assert {:ok, %Filling{}} = Ingredients.delete_filling(filling)
      assert_raise Ecto.NoResultsError, fn -> Ingredients.get_filling!(filling.id) end
    end

    test "change_filling/1 returns a filling changeset" do
      filling = filling_fixture()
      assert %Ecto.Changeset{} = Ingredients.change_filling(filling)
    end
  end
end
