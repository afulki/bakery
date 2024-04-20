defmodule BakeryWeb.FillingLiveTest do
  use BakeryWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bakery.IngredientsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_filling(_) do
    filling = filling_fixture()
    %{filling: filling}
  end

  describe "Index" do
    setup [:create_filling]

    test "lists all fillings", %{conn: conn, filling: filling} do
      {:ok, _index_live, html} = live(conn, ~p"/fillings")

      assert html =~ "Listing Fillings"
      assert html =~ filling.name
    end

    test "saves new filling", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/fillings")

      assert index_live |> element("a", "New Filling") |> render_click() =~
               "New Filling"

      assert_patch(index_live, ~p"/fillings/new")

      assert index_live
             |> form("#filling-form", filling: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#filling-form", filling: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fillings")

      html = render(index_live)
      assert html =~ "Filling created successfully"
      assert html =~ "some name"
    end

    test "updates filling in listing", %{conn: conn, filling: filling} do
      {:ok, index_live, _html} = live(conn, ~p"/fillings")

      assert index_live |> element("#fillings-#{filling.id} a", "Edit") |> render_click() =~
               "Edit Filling"

      assert_patch(index_live, ~p"/fillings/#{filling}/edit")

      assert index_live
             |> form("#filling-form", filling: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#filling-form", filling: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fillings")

      html = render(index_live)
      assert html =~ "Filling updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes filling in listing", %{conn: conn, filling: filling} do
      {:ok, index_live, _html} = live(conn, ~p"/fillings")

      assert index_live |> element("#fillings-#{filling.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#fillings-#{filling.id}")
    end
  end

  describe "Show" do
    setup [:create_filling]

    test "displays filling", %{conn: conn, filling: filling} do
      {:ok, _show_live, html} = live(conn, ~p"/fillings/#{filling}")

      assert html =~ "Show Filling"
      assert html =~ filling.name
    end

    test "updates filling within modal", %{conn: conn, filling: filling} do
      {:ok, show_live, _html} = live(conn, ~p"/fillings/#{filling}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Filling"

      assert_patch(show_live, ~p"/fillings/#{filling}/show/edit")

      assert show_live
             |> form("#filling-form", filling: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#filling-form", filling: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/fillings/#{filling}")

      html = render(show_live)
      assert html =~ "Filling updated successfully"
      assert html =~ "some updated name"
    end
  end
end
