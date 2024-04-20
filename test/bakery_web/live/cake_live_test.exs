defmodule BakeryWeb.CakeLiveTest do
  use BakeryWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bakery.EventsFixtures

  @create_attrs %{tiers: 42, shape: "some shape", style: "some style", base_price: "120.5", num_guests: 42, t1_flavor: "some t1_flavor", t2_flavor: "some t2_flavor", t3_flavor: "some t3_flavor", t4_flavor: "some t4_flavor", t5_flavor: "some t5_flavor", t1_filling: "some t1_filling", t2_filling: "some t2_filling", t3_filling: "some t3_filling", t4_filling: "some t4_filling", t5_filling: "some t5_filling", t1_add_cost: "120.5", t2_add_cost: "120.5", t3_add_cost: "120.5", t4_add_cost: "120.5", t5_add_cost: "120.5", t1_description: "some t1_description", t2_description: "some t2_description", t3_description: "some t3_description", t4_description: "some t4_description", t5_description: "some t5_description"}
  @update_attrs %{tiers: 43, shape: "some updated shape", style: "some updated style", base_price: "456.7", num_guests: 43, t1_flavor: "some updated t1_flavor", t2_flavor: "some updated t2_flavor", t3_flavor: "some updated t3_flavor", t4_flavor: "some updated t4_flavor", t5_flavor: "some updated t5_flavor", t1_filling: "some updated t1_filling", t2_filling: "some updated t2_filling", t3_filling: "some updated t3_filling", t4_filling: "some updated t4_filling", t5_filling: "some updated t5_filling", t1_add_cost: "456.7", t2_add_cost: "456.7", t3_add_cost: "456.7", t4_add_cost: "456.7", t5_add_cost: "456.7", t1_description: "some updated t1_description", t2_description: "some updated t2_description", t3_description: "some updated t3_description", t4_description: "some updated t4_description", t5_description: "some updated t5_description"}
  @invalid_attrs %{tiers: nil, shape: nil, style: nil, base_price: nil, num_guests: nil, t1_flavor: nil, t2_flavor: nil, t3_flavor: nil, t4_flavor: nil, t5_flavor: nil, t1_filling: nil, t2_filling: nil, t3_filling: nil, t4_filling: nil, t5_filling: nil, t1_add_cost: nil, t2_add_cost: nil, t3_add_cost: nil, t4_add_cost: nil, t5_add_cost: nil, t1_description: nil, t2_description: nil, t3_description: nil, t4_description: nil, t5_description: nil}

  defp create_cake(_) do
    cake = cake_fixture()
    %{cake: cake}
  end

  describe "Index" do
    setup [:create_cake]

    test "lists all cakes", %{conn: conn, cake: cake} do
      {:ok, _index_live, html} = live(conn, ~p"/cakes")

      assert html =~ "Listing Cakes"
      assert html =~ cake.shape
    end

    test "saves new cake", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/cakes")

      assert index_live |> element("a", "New Cake") |> render_click() =~
               "New Cake"

      assert_patch(index_live, ~p"/cakes/new")

      assert index_live
             |> form("#cake-form", cake: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cake-form", cake: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cakes")

      html = render(index_live)
      assert html =~ "Cake created successfully"
      assert html =~ "some shape"
    end

    test "updates cake in listing", %{conn: conn, cake: cake} do
      {:ok, index_live, _html} = live(conn, ~p"/cakes")

      assert index_live |> element("#cakes-#{cake.id} a", "Edit") |> render_click() =~
               "Edit Cake"

      assert_patch(index_live, ~p"/cakes/#{cake}/edit")

      assert index_live
             |> form("#cake-form", cake: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cake-form", cake: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cakes")

      html = render(index_live)
      assert html =~ "Cake updated successfully"
      assert html =~ "some updated shape"
    end

    test "deletes cake in listing", %{conn: conn, cake: cake} do
      {:ok, index_live, _html} = live(conn, ~p"/cakes")

      assert index_live |> element("#cakes-#{cake.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cakes-#{cake.id}")
    end
  end

  describe "Show" do
    setup [:create_cake]

    test "displays cake", %{conn: conn, cake: cake} do
      {:ok, _show_live, html} = live(conn, ~p"/cakes/#{cake}")

      assert html =~ "Show Cake"
      assert html =~ cake.shape
    end

    test "updates cake within modal", %{conn: conn, cake: cake} do
      {:ok, show_live, _html} = live(conn, ~p"/cakes/#{cake}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cake"

      assert_patch(show_live, ~p"/cakes/#{cake}/show/edit")

      assert show_live
             |> form("#cake-form", cake: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#cake-form", cake: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/cakes/#{cake}")

      html = render(show_live)
      assert html =~ "Cake updated successfully"
      assert html =~ "some updated shape"
    end
  end
end
