defmodule Bakery.VenuesTest do
  use Bakery.DataCase

  alias Bakery.Venues

  describe "venues" do
    alias Bakery.Venues.Venue

    import Bakery.VenuesFixtures

    @invalid_attrs %{
      name: nil,
      state: nil,
      zip: nil,
      street: nil,
      city: nil,
      contact: nil,
      phone: nil,
      email: nil,
      distance_in_miles: nil
    }

    test "list_venues/0 returns all venues" do
      venue = venue_fixture()
      assert Venues.list_venues() == [venue]
    end

    test "get_venue!/1 returns the venue with given id" do
      venue = venue_fixture()
      assert Venues.get_venue!(venue.id) == venue
    end

    test "create_venue/1 with valid data creates a venue" do
      valid_attrs = %{
        name: "some name",
        state: "some state",
        zip: "some zip",
        street: "some street",
        city: "some city",
        contact: "some contact",
        phone: "some phone",
        email: "some email",
        distance_in_miles: 42
      }

      assert {:ok, %Venue{} = venue} = Venues.create_venue(valid_attrs)
      assert venue.name == "some name"
      assert venue.state == "some state"
      assert venue.zip == "some zip"
      assert venue.street == "some street"
      assert venue.city == "some city"
      assert venue.contact == "some contact"
      assert venue.phone == "some phone"
      assert venue.email == "some email"
      assert venue.distance_in_miles == 42
    end

    test "create_venue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Venues.create_venue(@invalid_attrs)
    end

    test "update_venue/2 with valid data updates the venue" do
      venue = venue_fixture()

      update_attrs = %{
        name: "some updated name",
        state: "some updated state",
        zip: "some updated zip",
        street: "some updated street",
        city: "some updated city",
        contact: "some updated contact",
        phone: "some updated phone",
        email: "some updated email",
        distance_in_miles: 43
      }

      assert {:ok, %Venue{} = venue} = Venues.update_venue(venue, update_attrs)
      assert venue.name == "some updated name"
      assert venue.state == "some updated state"
      assert venue.zip == "some updated zip"
      assert venue.street == "some updated street"
      assert venue.city == "some updated city"
      assert venue.contact == "some updated contact"
      assert venue.phone == "some updated phone"
      assert venue.email == "some updated email"
      assert venue.distance_in_miles == 43
    end

    test "update_venue/2 with invalid data returns error changeset" do
      venue = venue_fixture()
      assert {:error, %Ecto.Changeset{}} = Venues.update_venue(venue, @invalid_attrs)
      assert venue == Venues.get_venue!(venue.id)
    end

    test "delete_venue/1 deletes the venue" do
      venue = venue_fixture()
      assert {:ok, %Venue{}} = Venues.delete_venue(venue)
      assert_raise Ecto.NoResultsError, fn -> Venues.get_venue!(venue.id) end
    end

    test "change_venue/1 returns a venue changeset" do
      venue = venue_fixture()
      assert %Ecto.Changeset{} = Venues.change_venue(venue)
    end
  end
end
