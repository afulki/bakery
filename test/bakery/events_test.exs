defmodule Bakery.EventsTest do
  use Bakery.DataCase

  alias Bakery.Events

  describe "sheet_cakes" do
    alias Bakery.Events.SheetCake

    import Bakery.EventsFixtures

    @invalid_attrs %{name: nil, quantity: nil, price: nil}

    test "list_sheet_cakes/0 returns all sheet_cakes" do
      sheet_cake = sheet_cake_fixture()
      assert Events.list_sheet_cakes() == [sheet_cake]
    end

    test "get_sheet_cake!/1 returns the sheet_cake with given id" do
      sheet_cake = sheet_cake_fixture()
      assert Events.get_sheet_cake!(sheet_cake.id) == sheet_cake
    end

    test "create_sheet_cake/1 with valid data creates a sheet_cake" do
      valid_attrs = %{name: "some name", quantity: 42, price: "120.5"}

      assert {:ok, %SheetCake{} = sheet_cake} = Events.create_sheet_cake(valid_attrs)
      assert sheet_cake.name == "some name"
      assert sheet_cake.quantity == 42
      assert sheet_cake.price == Decimal.new("120.5")
    end

    test "create_sheet_cake/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_sheet_cake(@invalid_attrs)
    end

    test "update_sheet_cake/2 with valid data updates the sheet_cake" do
      sheet_cake = sheet_cake_fixture()
      update_attrs = %{name: "some updated name", quantity: 43, price: "456.7"}

      assert {:ok, %SheetCake{} = sheet_cake} = Events.update_sheet_cake(sheet_cake, update_attrs)
      assert sheet_cake.name == "some updated name"
      assert sheet_cake.quantity == 43
      assert sheet_cake.price == Decimal.new("456.7")
    end

    test "update_sheet_cake/2 with invalid data returns error changeset" do
      sheet_cake = sheet_cake_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_sheet_cake(sheet_cake, @invalid_attrs)
      assert sheet_cake == Events.get_sheet_cake!(sheet_cake.id)
    end

    test "delete_sheet_cake/1 deletes the sheet_cake" do
      sheet_cake = sheet_cake_fixture()
      assert {:ok, %SheetCake{}} = Events.delete_sheet_cake(sheet_cake)
      assert_raise Ecto.NoResultsError, fn -> Events.get_sheet_cake!(sheet_cake.id) end
    end

    test "change_sheet_cake/1 returns a sheet_cake changeset" do
      sheet_cake = sheet_cake_fixture()
      assert %Ecto.Changeset{} = Events.change_sheet_cake(sheet_cake)
    end
  end
end
