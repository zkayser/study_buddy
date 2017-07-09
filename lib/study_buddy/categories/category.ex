defmodule StudyBuddy.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudyBuddy.Categories.Category


  schema "categories_categories" do
    field :name, :string
    belongs_to :user, StudyBuddy.Accounts.User
    has_many :subcategories, Category, foreign_key: :category_id
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def build_subcategory(%Category{} = category, sub_cat_attrs) do
    changeset = changeset(%Category{}, sub_cat_attrs)
    case changeset do
      %Ecto.Changeset{valid?: false} -> changeset
      _ -> Ecto.build_assoc(category, :subcategories, sub_cat_attrs)
    end
  end
end
