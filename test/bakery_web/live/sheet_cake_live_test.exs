defmodule BakeryWeb.SheetCakeLiveTest do
  use BakeryWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bakery.EventsFixtures

  @create_attrs %{name: "some name", quantity: 42, price: "120.5"}
  @update_attrs %{name: "some updated name", quantity: 43, price: "456.7"}
  @invalid_attrs %{name: nil, quantity: nil, price: nil}

  defp create_sheet_cake(_) do
    sheet_cake = sheet_cake_fixture()
    %{sheet_cake: sheet_cake}
  end

  describe "Index" do
    setup [:create_sheet_cake]

    test "lists all sheet_cakes", %{conn: conn, sheet_cake: sheet_cake} do
      {:ok, _index_live, html} = live(conn, ~p"/sheet_cakes")

      assert html =~ "Listing Sheet cakes"
      assert html =~ sheet_cake.name
    end

    test "saves new sheet_cake", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/sheet_cakes")

      assert index_live |> element("a", "New Sheet cake") |> render_click() =~
               "New Sheet cake"

      assert_patch(index_live, ~p"/sheet_cakes/new")

      assert index_live
             |> form("#sheet_cake-form", sheet_cake: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#sheet_cake-form", sheet_cake: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/sheet_cakes")

      html = render(index_live)
      assert html =~ "Sheet cake created successfully"
      assert html =~ "some name"
    end

    test "updates sheet_cake in listing", %{conn: conn, sheet_cake: sheet_cake} do
      {:ok, index_live, _html} = live(conn, ~p"/sheet_cakes")

      assert index_live |> element("#sheet_cakes-#{sheet_cake.id} a", "Edit") |> render_click() =~
               "Edit Sheet cake"

      assert_patch(index_live, ~p"/sheet_cakes/#{sheet_cake}/edit")

      assert index_live
             |> form("#sheet_cake-form", sheet_cake: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#sheet_cake-form", sheet_cake: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/sheet_cakes")

      html = render(index_live)
      assert html =~ "Sheet cake updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes sheet_cake in listing", %{conn: conn, sheet_cake: sheet_cake} do
      {:ok, index_live, _html} = live(conn, ~p"/sheet_cakes")

      assert index_live |> element("#sheet_cakes-#{sheet_cake.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#sheet_cakes-#{sheet_cake.id}")
    end
  end

  describe "Show" do
    setup [:create_sheet_cake]

    test "displays sheet_cake", %{conn: conn, sheet_cake: sheet_cake} do
      {:ok, _show_live, html} = live(conn, ~p"/sheet_cakes/#{sheet_cake}")

      assert html =~ "Show Sheet cake"
      assert html =~ sheet_cake.name
    end

    test "updates sheet_cake within modal", %{conn: conn, sheet_cake: sheet_cake} do
      {:ok, show_live, _html} = live(conn, ~p"/sheet_cakes/#{sheet_cake}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Sheet cake"

      assert_patch(show_live, ~p"/sheet_cakes/#{sheet_cake}/show/edit")

      assert show_live
             |> form("#sheet_cake-form", sheet_cake: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#sheet_cake-form", sheet_cake: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/sheet_cakes/#{sheet_cake}")

      html = render(show_live)
      assert html =~ "Sheet cake updated successfully"
      assert html =~ "some updated name"
    end
  end
end
