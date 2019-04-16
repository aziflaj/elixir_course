defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of strings, representing a deck of cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Hearts", "Clubs", "Diamonds"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    deck
      |> Enum.shuffle
  end

  @doc """
    Checks whether the deck contains a given card

    ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Five of Diamonds")
      true

  """
  def contains?(deck, hand) do
    deck
      |> Enum.member?(hand)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck. The `count`
    argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, count) do
    deck
      |> Enum.split(count) # returns a tuple {dealed hand, rest of deck}
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck) # make deck writeable to file
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> "File #{filename} does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
      |> Cards.shuffle
      |> Cards.deal(hand_size)
  end
end
