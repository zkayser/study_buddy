defmodule StudyBuddy.Categories.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudyBuddy.Categories.Topic


  schema "categories_topics" do
    field :title, :string
    belongs_to :category, StudyBuddy.Categories.Category

    timestamps()
  end

  @doc false
  def changeset(%Topic{} = topic, attrs) do
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
