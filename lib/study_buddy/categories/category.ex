defmodule StudyBuddy.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudyBuddy.Categories.{Category, Topic}
  alias StudyBuddy.Repo

  @type category :: %Category{}
  @type topic :: %Topic{}


  schema "categories_categories" do
    field :name, :string
    belongs_to :user, StudyBuddy.Accounts.User
    has_many :subcategories, Category, foreign_key: :category_id
    has_many :topics, Topic
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs \\ %{}) do
    category
    |> cast(attrs, [:name, :category_id])
    |> validate_required([:name])
  end

  def build_subcategory(%Category{} = category, %Category{} = sub_cat) do
    changeset = changeset(sub_cat, Map.take(sub_cat, [:name]))
    case changeset do
      %Ecto.Changeset{valid?: false} -> changeset
      _ -> Ecto.build_assoc(category, :subcategories, sub_cat)
    end
  end

  def build_topic(%Category{} = category, %Topic{} = topic) do
    changeset = changeset(topic, Map.take(topic, [:title]))
    case changeset do
      %Ecto.Changeset{valid?: false} -> changeset
      _ -> Ecto.build_assoc(category, :topics, topic)
    end
  end

  @doc """
  build_relation is an abstraction meant to make building relationships with
  a category easier. Note that Ecto.build_assoc called in the happy path returns
  a struct for the given association, but does not commit the association to the
  database. Call Repo.insert to insert the struct data to the database.

  Parameters should be as follows:
  `relation_type` => atom
  `cat` => the parent category
  `assoc` => the struct being associated.

  If the changeset made in the first step of the function is invalid,
  note that this function will return the invalid changeset as is. Otherwise
  it will return a struct for the association (the belongs_to side of the
  association)
  """
  @spec build_relation(atom, map(), map()) :: map() | map()
  def build_relation(relation_type, %Category{} = cat, assoc) 
  when relation_type in [:subcategories, :topics] do
    Repo.preload(cat, [relation_type])
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(relation_type, [assoc])
    |> commit_changes(%{category: cat, association: assoc, module: get_module_name(relation_type)})
  end

  def build_belong_to_relation(relation_type, %Category{} = cat, assoc) when relation_type in [:user] do
    Repo.preload(cat, [relation_type])
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(relation_type, assoc)
    |> commit_changes(%{category: cat, association: assoc, module: get_module_name(relation_type)})
  end

  defp commit_changes(changeset, %{category: cat, association: assoc, module: mod}) do
    case changeset do
      %Ecto.Changeset{valid?: false} -> {:error, cat, assoc}
      _ ->
        {:ok, parent_cat} = Repo.update(changeset)
        updated_assoc = Repo.get(mod, assoc.id)
        {:ok, parent_cat, updated_assoc}
    end
  end

  defp get_module_name(atom) do
    case atom do
      :subcategories -> Category
      :topics -> Topic
      :user -> StudyBuddy.Accounts.User
      _ -> raise ArgumentError, "module not recognized"
    end
  end
end
