defmodule Bakery.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bakery.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        balance_paid: true,
        balance_paid_date: ~D[2024-04-19],
        c1_email: "some c1_email",
        c1_name: "some c1_name",
        c1_phone: "some c1_phone",
        c2_email: "some c2_email",
        c2_name: "some c2_name",
        c2_phone: "some c2_phone",
        delivery_time: ~T[14:00:00],
        deposit_paid: true,
        deposit_paid_date: ~D[2024-04-19],
        name: "some name",
        photo_name: "some photo_name",
        photo_phone: "some photo_phone",
        photo_social: "some photo_social",
        planner_email: "some planner_email",
        planner_name: "some planner_name",
        planner_phone: "some planner_phone",
        planner_social: "some planner_social",
        reception_time: ~T[14:00:00],
        when: ~D[2024-04-19]
      })
      |> Bakery.Events.create_event()

    event
  end

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        c1_email: "some c1_email",
        c1_name: "some c1_name",
        c1_phone: "some c1_phone",
        c2_email: "some c2_email",
        c2_name: "some c2_name",
        c2_phone: "some c2_phone",
        delivery_time: ~T[14:00:00],
        name: "some name",
        reception_time: ~T[14:00:00],
        when: ~D[2024-04-19]
      })
      |> Bakery.Events.create_event()

    event
  end

  @doc """
  Generate a cake.
  """
  def cake_fixture(attrs \\ %{}) do
    {:ok, cake} =
      attrs
      |> Enum.into(%{
        base_price: "120.5",
        num_guests: 42,
        shape: "some shape",
        style: "some style",
        t1_add_cost: "120.5",
        t1_filling: "some t1_filling",
        t1_flavor: "some t1_flavor",
        t2_add_cost: "120.5",
        t2_filling: "some t2_filling",
        t2_flavor: "some t2_flavor",
        t3_filling: "some t3_filling",
        t3_flavor: "some t3_flavor",
        t4_filling: "some t4_filling",
        t4_flavor: "some t4_flavor",
        t5_filling: "some t5_filling",
        t5_flavor: "some t5_flavor",
        tiers: 42
      })
      |> Bakery.Events.create_cake()

    cake
  end

  @doc """
  Generate a cake.
  """
  def cake_fixture(attrs \\ %{}) do
    {:ok, cake} =
      attrs
      |> Enum.into(%{
        base_price: "120.5",
        num_guests: 42,
        shape: "some shape",
        style: "some style",
        t1_add_cost: "120.5",
        t1_description: "some t1_description",
        t1_filling: "some t1_filling",
        t1_flavor: "some t1_flavor",
        t2_add_cost: "120.5",
        t2_description: "some t2_description",
        t2_filling: "some t2_filling",
        t2_flavor: "some t2_flavor",
        t3_add_cost: "120.5",
        t3_description: "some t3_description",
        t3_filling: "some t3_filling",
        t3_flavor: "some t3_flavor",
        t4_add_cost: "120.5",
        t4_description: "some t4_description",
        t4_filling: "some t4_filling",
        t4_flavor: "some t4_flavor",
        t5_add_cost: "120.5",
        t5_description: "some t5_description",
        t5_filling: "some t5_filling",
        t5_flavor: "some t5_flavor",
        tiers: 42
      })
      |> Bakery.Events.create_cake()

    cake
  end
end
