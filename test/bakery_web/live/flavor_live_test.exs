defmodule BakeryWeb.FlavorLiveTest do
  use BakeryWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bakery.IngredientsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_flavor(_) do
    flavor = flavor_fixture()
    %{flavor: flavor}
  end

  describe "Index" do
    setup [:create_flavor]

    test "lists all flavors", %{conn: conn, flavor: flavor} do
      {:ok, _index_live, html} = live(conn, ~p"/flavors")

      assert html =~ "Listing Flavors"
      assert html =~ flavor.name
    end

    test "saves new flavor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/flavors")

      assert index_live |> element("a", "New Flavor") |> render_click() =~
               "New Flavor"

      assert_patch(index_live, ~p"/flavors/new")

      assert index_live
             |> form("#flavor-form", flavor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#flavor-form", flavor: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/flavors")

      html = render(index_live)
      assert html =~ "Flavor created successfully"
      assert html =~ "some name"
    end

    test "updates flavor in listing", %{conn: conn, flavor: flavor} do
      {:ok, index_live, _html} = live(conn, ~p"/flavors")

      assert index_live |> element("#flavors-#{flavor.id} a", "Edit") |> render_click() =~
               "Edit Flavor"

      assert_patch(index_live, ~p"/flavors/#{flavor}/edit")

      assert index_live
             |> form("#flavor-form", flavor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#flavor-form", flavor: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/flavors")

      html = render(index_live)
      assert html =~ "Flavor updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes flavor in listing", %{conn: conn, flavor: flavor} do
      {:ok, index_live, _html} = live(conn, ~p"/flavors")

      assert index_live |> element("#flavors-#{flavor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#flavors-#{flavor.id}")
    end
  end

  describe "Show" do
    setup [:create_flavor]

    test "displays flavor", %{conn: conn, flavor: flavor} do
      {:ok, _show_live, html} = live(conn, ~p"/flavors/#{flavor}")

      assert html =~ "Show Flavor"
      assert html =~ flavor.name
    end

    test "updates flavor within modal", %{conn: conn, flavor: flavor} do
      {:ok, show_live, _html} = live(conn, ~p"/flavors/#{flavor}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Flavor"

      assert_patch(show_live, ~p"/flavors/#{flavor}/show/edit")

      assert show_live
             |> form("#flavor-form", flavor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#flavor-form", flavor: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/flavors/#{flavor}")

      html = render(show_live)
      assert html =~ "Flavor updated successfully"
      assert html =~ "some updated name"
    end
  end
end
