defmodule BakeryWeb.Components.Layouts.App do
  alias Phoenix.LiveView.JS

  def toggle_dropdown_menu do
    JS.toggle(
      to: "#dropdown_menu",
      in:
        {"transition ease-out duration-100", "transform opacity-0 translate-y-[-10%]",
         "transform opacity-100 translate-y-0"},
      out:
        {"transition ease-in duration-75", "transform opacity-100 translate-y-0",
         "transform opacity-0 translate-y-[-10%]"}
    )
  end

  def toggle_mobile_menu do
    JS.toggle(
      to: "#mobile-menu",
      in:
        {"transition ease-out duration-100", "transform opacity-0 translate-y-[-10%]",
         "transform opacity-100 translate-y-0"},
      out:
        {"transition ease-in duration-75", "transform opacity-100 translate-y-0",
         "transform opacity-0 translate-y-[-10%]"}
    )
  end

  def gravatar(""), do: "https://www.gravatar.com/avatar/"

  def gravatar(email) do
    hash =
      email
      |> String.trim()
      |> String.downcase()
      |> :erlang.md5()
      |> Base.encode16(case: :lower)

    "https://www.gravatar.com/avatar/#{hash}?s=150&d=identicon"
  end
end
