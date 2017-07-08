defmodule StudyBuddy.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudyBuddy.Categories.Category


  schema "categories_categories" do
    field :name, :string
    belongs_to :user, StudyBuddy.Accounts.User
    has_many :subcategories, StudyBuddy.Categories.Category, foreign_key: :category_id
    belongs_to :category, StudyBuddy.Categories.Category

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
