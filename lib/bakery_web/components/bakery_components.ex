defmodule BakeryWeb.BakeryComponents do
  @moduledoc false
  use Phoenix.Component

  attr :id, :string, required: true
  slot :inner_block, required: true

  def line(assigns) do
    ~H"""
    <div class="relative">
      <div class="absolute inset-0 flex items-center" aria-hidden="true">
        <div class="w-full border-t border-gray-300"></div>
      </div>
      <div class="relative flex justify-start">
        <span class="bg-white pr-3 text-base font-semibold leading-6 text-gray-900">
          <%= render_slot(@inner_block) %>
        </span>
      </div>
    </div>
    """
  end

  def panel_title(assigns) do
    ~H"""
    <div>
      <h2 class="font-semibold"><%= render_slot(@inner_block) %></h2>
      <hr class="border-b-2 border-rose-200" />
    </div>
    """
  end

  attr :id, :string, required: true
  attr :title, :string, required: true
  slot :inner_block, required: true

  def item(assigns) do
    ~H"""
    <div class="flex flex-row">
      <div class="basis-1/4 text-base font-bold">
        <%= @title %>
      </div>
      <div class="basis-3/4 text-base ">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  def money_item(assigns) do
    ~H"""
    <div class="flex flex-row p-3 rounded-md">
      <div class="basis-3/4 text-base">
        <%= @title %>
      </div>
      <div class="basis-1/4 text-base font-normal ">
        <div class="grid justify-items-end">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end

  def total_item(assigns) do
    ~H"""
    <div class="flex flex-row p-3 bg-rose-50 rounded-md">
      <div class="basis-3/4 text-base">
        <%= @title %>
      </div>
      <div class="basis-1/4 text-base font-bold ">
        <div class="grid justify-items-end">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end
end
