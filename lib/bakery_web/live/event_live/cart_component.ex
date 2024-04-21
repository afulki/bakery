defmodule BakeryWeb.EventLive.CartComponent do
  use BakeryWeb, :live_component

  def description_from_cake(cake) do
    "#{shape_name(cake.shape)}, #{tier_name(cake.tiers)}, Serves #{cake.num_guests}"
  end

  defp tier_name(1), do: "single tier"
  defp tier_name(n), do: "#{n} tiers"

  defp shape_name("round"), do: "Round"
  defp shape_name("heart"), do: "Heart shaped"
  defp shape_name("square"), do: "Square"
end
