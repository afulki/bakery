defmodule Bakery.EventsTest do
  use Bakery.DataCase

  alias Bakery.Events

  describe "events" do
    alias Bakery.Events.Event

    import Bakery.EventsFixtures

    @invalid_attrs %{name: nil, when: nil, deposit_paid: nil, deposit_paid_date: nil, balance_paid: nil, balance_paid_date: nil, delivery_time: nil, reception_time: nil, c1_name: nil, c1_email: nil, c1_phone: nil, c2_name: nil, c2_phone: nil, c2_email: nil, photo_name: nil, photo_phone: nil, photo_social: nil, planner_name: nil, planner_email: nil, planner_phone: nil, planner_social: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{name: "some name", when: ~D[2024-04-19], deposit_paid: true, deposit_paid_date: ~D[2024-04-19], balance_paid: true, balance_paid_date: ~D[2024-04-19], delivery_time: ~T[14:00:00], reception_time: ~T[14:00:00], c1_name: "some c1_name", c1_email: "some c1_email", c1_phone: "some c1_phone", c2_name: "some c2_name", c2_phone: "some c2_phone", c2_email: "some c2_email", photo_name: "some photo_name", photo_phone: "some photo_phone", photo_social: "some photo_social", planner_name: "some planner_name", planner_email: "some planner_email", planner_phone: "some planner_phone", planner_social: "some planner_social"}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.name == "some name"
      assert event.when == ~D[2024-04-19]
      assert event.deposit_paid == true
      assert event.deposit_paid_date == ~D[2024-04-19]
      assert event.balance_paid == true
      assert event.balance_paid_date == ~D[2024-04-19]
      assert event.delivery_time == ~T[14:00:00]
      assert event.reception_time == ~T[14:00:00]
      assert event.c1_name == "some c1_name"
      assert event.c1_email == "some c1_email"
      assert event.c1_phone == "some c1_phone"
      assert event.c2_name == "some c2_name"
      assert event.c2_phone == "some c2_phone"
      assert event.c2_email == "some c2_email"
      assert event.photo_name == "some photo_name"
      assert event.photo_phone == "some photo_phone"
      assert event.photo_social == "some photo_social"
      assert event.planner_name == "some planner_name"
      assert event.planner_email == "some planner_email"
      assert event.planner_phone == "some planner_phone"
      assert event.planner_social == "some planner_social"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{name: "some updated name", when: ~D[2024-04-20], deposit_paid: false, deposit_paid_date: ~D[2024-04-20], balance_paid: false, balance_paid_date: ~D[2024-04-20], delivery_time: ~T[15:01:01], reception_time: ~T[15:01:01], c1_name: "some updated c1_name", c1_email: "some updated c1_email", c1_phone: "some updated c1_phone", c2_name: "some updated c2_name", c2_phone: "some updated c2_phone", c2_email: "some updated c2_email", photo_name: "some updated photo_name", photo_phone: "some updated photo_phone", photo_social: "some updated photo_social", planner_name: "some updated planner_name", planner_email: "some updated planner_email", planner_phone: "some updated planner_phone", planner_social: "some updated planner_social"}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.name == "some updated name"
      assert event.when == ~D[2024-04-20]
      assert event.deposit_paid == false
      assert event.deposit_paid_date == ~D[2024-04-20]
      assert event.balance_paid == false
      assert event.balance_paid_date == ~D[2024-04-20]
      assert event.delivery_time == ~T[15:01:01]
      assert event.reception_time == ~T[15:01:01]
      assert event.c1_name == "some updated c1_name"
      assert event.c1_email == "some updated c1_email"
      assert event.c1_phone == "some updated c1_phone"
      assert event.c2_name == "some updated c2_name"
      assert event.c2_phone == "some updated c2_phone"
      assert event.c2_email == "some updated c2_email"
      assert event.photo_name == "some updated photo_name"
      assert event.photo_phone == "some updated photo_phone"
      assert event.photo_social == "some updated photo_social"
      assert event.planner_name == "some updated planner_name"
      assert event.planner_email == "some updated planner_email"
      assert event.planner_phone == "some updated planner_phone"
      assert event.planner_social == "some updated planner_social"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end

  describe "events" do
    alias Bakery.Events.Event

    import Bakery.EventsFixtures

    @invalid_attrs %{name: nil, when: nil, delivery_time: nil, reception_time: nil, c1_name: nil, c1_email: nil, c1_phone: nil, c2_name: nil, c2_phone: nil, c2_email: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{name: "some name", when: ~D[2024-04-19], delivery_time: ~T[14:00:00], reception_time: ~T[14:00:00], c1_name: "some c1_name", c1_email: "some c1_email", c1_phone: "some c1_phone", c2_name: "some c2_name", c2_phone: "some c2_phone", c2_email: "some c2_email"}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.name == "some name"
      assert event.when == ~D[2024-04-19]
      assert event.delivery_time == ~T[14:00:00]
      assert event.reception_time == ~T[14:00:00]
      assert event.c1_name == "some c1_name"
      assert event.c1_email == "some c1_email"
      assert event.c1_phone == "some c1_phone"
      assert event.c2_name == "some c2_name"
      assert event.c2_phone == "some c2_phone"
      assert event.c2_email == "some c2_email"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{name: "some updated name", when: ~D[2024-04-20], delivery_time: ~T[15:01:01], reception_time: ~T[15:01:01], c1_name: "some updated c1_name", c1_email: "some updated c1_email", c1_phone: "some updated c1_phone", c2_name: "some updated c2_name", c2_phone: "some updated c2_phone", c2_email: "some updated c2_email"}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.name == "some updated name"
      assert event.when == ~D[2024-04-20]
      assert event.delivery_time == ~T[15:01:01]
      assert event.reception_time == ~T[15:01:01]
      assert event.c1_name == "some updated c1_name"
      assert event.c1_email == "some updated c1_email"
      assert event.c1_phone == "some updated c1_phone"
      assert event.c2_name == "some updated c2_name"
      assert event.c2_phone == "some updated c2_phone"
      assert event.c2_email == "some updated c2_email"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end

  describe "cakes" do
    alias Bakery.Events.Cake

    import Bakery.EventsFixtures

    @invalid_attrs %{tiers: nil, shape: nil, style: nil, base_price: nil, num_guests: nil, t1_flavor: nil, t2_flavor: nil, t3_flavor: nil, t4_flavor: nil, t5_flavor: nil, t1_filling: nil, t2_filling: nil, t3_filling: nil, t4_filling: nil, t5_filling: nil, t1_add_cost: nil, t2_add_cost: nil}

    test "list_cakes/0 returns all cakes" do
      cake = cake_fixture()
      assert Events.list_cakes() == [cake]
    end

    test "get_cake!/1 returns the cake with given id" do
      cake = cake_fixture()
      assert Events.get_cake!(cake.id) == cake
    end

    test "create_cake/1 with valid data creates a cake" do
      valid_attrs = %{tiers: 42, shape: "some shape", style: "some style", base_price: "120.5", num_guests: 42, t1_flavor: "some t1_flavor", t2_flavor: "some t2_flavor", t3_flavor: "some t3_flavor", t4_flavor: "some t4_flavor", t5_flavor: "some t5_flavor", t1_filling: "some t1_filling", t2_filling: "some t2_filling", t3_filling: "some t3_filling", t4_filling: "some t4_filling", t5_filling: "some t5_filling", t1_add_cost: "120.5", t2_add_cost: "120.5"}

      assert {:ok, %Cake{} = cake} = Events.create_cake(valid_attrs)
      assert cake.tiers == 42
      assert cake.shape == "some shape"
      assert cake.style == "some style"
      assert cake.base_price == Decimal.new("120.5")
      assert cake.num_guests == 42
      assert cake.t1_flavor == "some t1_flavor"
      assert cake.t2_flavor == "some t2_flavor"
      assert cake.t3_flavor == "some t3_flavor"
      assert cake.t4_flavor == "some t4_flavor"
      assert cake.t5_flavor == "some t5_flavor"
      assert cake.t1_filling == "some t1_filling"
      assert cake.t2_filling == "some t2_filling"
      assert cake.t3_filling == "some t3_filling"
      assert cake.t4_filling == "some t4_filling"
      assert cake.t5_filling == "some t5_filling"
      assert cake.t1_add_cost == Decimal.new("120.5")
      assert cake.t2_add_cost == Decimal.new("120.5")
    end

    test "create_cake/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_cake(@invalid_attrs)
    end

    test "update_cake/2 with valid data updates the cake" do
      cake = cake_fixture()
      update_attrs = %{tiers: 43, shape: "some updated shape", style: "some updated style", base_price: "456.7", num_guests: 43, t1_flavor: "some updated t1_flavor", t2_flavor: "some updated t2_flavor", t3_flavor: "some updated t3_flavor", t4_flavor: "some updated t4_flavor", t5_flavor: "some updated t5_flavor", t1_filling: "some updated t1_filling", t2_filling: "some updated t2_filling", t3_filling: "some updated t3_filling", t4_filling: "some updated t4_filling", t5_filling: "some updated t5_filling", t1_add_cost: "456.7", t2_add_cost: "456.7"}

      assert {:ok, %Cake{} = cake} = Events.update_cake(cake, update_attrs)
      assert cake.tiers == 43
      assert cake.shape == "some updated shape"
      assert cake.style == "some updated style"
      assert cake.base_price == Decimal.new("456.7")
      assert cake.num_guests == 43
      assert cake.t1_flavor == "some updated t1_flavor"
      assert cake.t2_flavor == "some updated t2_flavor"
      assert cake.t3_flavor == "some updated t3_flavor"
      assert cake.t4_flavor == "some updated t4_flavor"
      assert cake.t5_flavor == "some updated t5_flavor"
      assert cake.t1_filling == "some updated t1_filling"
      assert cake.t2_filling == "some updated t2_filling"
      assert cake.t3_filling == "some updated t3_filling"
      assert cake.t4_filling == "some updated t4_filling"
      assert cake.t5_filling == "some updated t5_filling"
      assert cake.t1_add_cost == Decimal.new("456.7")
      assert cake.t2_add_cost == Decimal.new("456.7")
    end

    test "update_cake/2 with invalid data returns error changeset" do
      cake = cake_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_cake(cake, @invalid_attrs)
      assert cake == Events.get_cake!(cake.id)
    end

    test "delete_cake/1 deletes the cake" do
      cake = cake_fixture()
      assert {:ok, %Cake{}} = Events.delete_cake(cake)
      assert_raise Ecto.NoResultsError, fn -> Events.get_cake!(cake.id) end
    end

    test "change_cake/1 returns a cake changeset" do
      cake = cake_fixture()
      assert %Ecto.Changeset{} = Events.change_cake(cake)
    end
  end

  describe "cakes" do
    alias Bakery.Events.Cake

    import Bakery.EventsFixtures

    @invalid_attrs %{tiers: nil, shape: nil, style: nil, base_price: nil, num_guests: nil, t1_flavor: nil, t2_flavor: nil, t3_flavor: nil, t4_flavor: nil, t5_flavor: nil, t1_filling: nil, t2_filling: nil, t3_filling: nil, t4_filling: nil, t5_filling: nil, t1_add_cost: nil, t2_add_cost: nil, t3_add_cost: nil, t4_add_cost: nil, t5_add_cost: nil, t1_description: nil, t2_description: nil, t3_description: nil, t4_description: nil, t5_description: nil}

    test "list_cakes/0 returns all cakes" do
      cake = cake_fixture()
      assert Events.list_cakes() == [cake]
    end

    test "get_cake!/1 returns the cake with given id" do
      cake = cake_fixture()
      assert Events.get_cake!(cake.id) == cake
    end

    test "create_cake/1 with valid data creates a cake" do
      valid_attrs = %{tiers: 42, shape: "some shape", style: "some style", base_price: "120.5", num_guests: 42, t1_flavor: "some t1_flavor", t2_flavor: "some t2_flavor", t3_flavor: "some t3_flavor", t4_flavor: "some t4_flavor", t5_flavor: "some t5_flavor", t1_filling: "some t1_filling", t2_filling: "some t2_filling", t3_filling: "some t3_filling", t4_filling: "some t4_filling", t5_filling: "some t5_filling", t1_add_cost: "120.5", t2_add_cost: "120.5", t3_add_cost: "120.5", t4_add_cost: "120.5", t5_add_cost: "120.5", t1_description: "some t1_description", t2_description: "some t2_description", t3_description: "some t3_description", t4_description: "some t4_description", t5_description: "some t5_description"}

      assert {:ok, %Cake{} = cake} = Events.create_cake(valid_attrs)
      assert cake.tiers == 42
      assert cake.shape == "some shape"
      assert cake.style == "some style"
      assert cake.base_price == Decimal.new("120.5")
      assert cake.num_guests == 42
      assert cake.t1_flavor == "some t1_flavor"
      assert cake.t2_flavor == "some t2_flavor"
      assert cake.t3_flavor == "some t3_flavor"
      assert cake.t4_flavor == "some t4_flavor"
      assert cake.t5_flavor == "some t5_flavor"
      assert cake.t1_filling == "some t1_filling"
      assert cake.t2_filling == "some t2_filling"
      assert cake.t3_filling == "some t3_filling"
      assert cake.t4_filling == "some t4_filling"
      assert cake.t5_filling == "some t5_filling"
      assert cake.t1_add_cost == Decimal.new("120.5")
      assert cake.t2_add_cost == Decimal.new("120.5")
      assert cake.t3_add_cost == Decimal.new("120.5")
      assert cake.t4_add_cost == Decimal.new("120.5")
      assert cake.t5_add_cost == Decimal.new("120.5")
      assert cake.t1_description == "some t1_description"
      assert cake.t2_description == "some t2_description"
      assert cake.t3_description == "some t3_description"
      assert cake.t4_description == "some t4_description"
      assert cake.t5_description == "some t5_description"
    end

    test "create_cake/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_cake(@invalid_attrs)
    end

    test "update_cake/2 with valid data updates the cake" do
      cake = cake_fixture()
      update_attrs = %{tiers: 43, shape: "some updated shape", style: "some updated style", base_price: "456.7", num_guests: 43, t1_flavor: "some updated t1_flavor", t2_flavor: "some updated t2_flavor", t3_flavor: "some updated t3_flavor", t4_flavor: "some updated t4_flavor", t5_flavor: "some updated t5_flavor", t1_filling: "some updated t1_filling", t2_filling: "some updated t2_filling", t3_filling: "some updated t3_filling", t4_filling: "some updated t4_filling", t5_filling: "some updated t5_filling", t1_add_cost: "456.7", t2_add_cost: "456.7", t3_add_cost: "456.7", t4_add_cost: "456.7", t5_add_cost: "456.7", t1_description: "some updated t1_description", t2_description: "some updated t2_description", t3_description: "some updated t3_description", t4_description: "some updated t4_description", t5_description: "some updated t5_description"}

      assert {:ok, %Cake{} = cake} = Events.update_cake(cake, update_attrs)
      assert cake.tiers == 43
      assert cake.shape == "some updated shape"
      assert cake.style == "some updated style"
      assert cake.base_price == Decimal.new("456.7")
      assert cake.num_guests == 43
      assert cake.t1_flavor == "some updated t1_flavor"
      assert cake.t2_flavor == "some updated t2_flavor"
      assert cake.t3_flavor == "some updated t3_flavor"
      assert cake.t4_flavor == "some updated t4_flavor"
      assert cake.t5_flavor == "some updated t5_flavor"
      assert cake.t1_filling == "some updated t1_filling"
      assert cake.t2_filling == "some updated t2_filling"
      assert cake.t3_filling == "some updated t3_filling"
      assert cake.t4_filling == "some updated t4_filling"
      assert cake.t5_filling == "some updated t5_filling"
      assert cake.t1_add_cost == Decimal.new("456.7")
      assert cake.t2_add_cost == Decimal.new("456.7")
      assert cake.t3_add_cost == Decimal.new("456.7")
      assert cake.t4_add_cost == Decimal.new("456.7")
      assert cake.t5_add_cost == Decimal.new("456.7")
      assert cake.t1_description == "some updated t1_description"
      assert cake.t2_description == "some updated t2_description"
      assert cake.t3_description == "some updated t3_description"
      assert cake.t4_description == "some updated t4_description"
      assert cake.t5_description == "some updated t5_description"
    end

    test "update_cake/2 with invalid data returns error changeset" do
      cake = cake_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_cake(cake, @invalid_attrs)
      assert cake == Events.get_cake!(cake.id)
    end

    test "delete_cake/1 deletes the cake" do
      cake = cake_fixture()
      assert {:ok, %Cake{}} = Events.delete_cake(cake)
      assert_raise Ecto.NoResultsError, fn -> Events.get_cake!(cake.id) end
    end

    test "change_cake/1 returns a cake changeset" do
      cake = cake_fixture()
      assert %Ecto.Changeset{} = Events.change_cake(cake)
    end
  end
end
