defmodule StudyBuddy.Categories.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudyBuddy.Categories.Topic
  alias StudyBuddy.Repo


  schema "categories_topics" do
    field :title, :string
    belongs_to :category, StudyBuddy.Categories.Category
    has_many :exercises, StudyBuddy.Exercises.Exercise

    timestamps()
  end

  @doc false
  def changeset(%Topic{} = topic, attrs) do
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end

  def build_relation(relation_type, %Topic{} = topic, assoc) when relation_type in [:exercises] do
    Repo.preload(topic, [relation_type])
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(relation_type, [assoc])
    |> commit_changes(%{topic: topic, association: assoc, module: get_module_name(relation_type)})
  end

  defp commit_changes(changeset, %{topic: topic, association: assoc, module: mod}) do
    case changeset do
      %Ecto.Changeset{valid?: false} -> {:error, topic, assoc}
      _ ->
        {:ok, topic} = Repo.update(changeset)
        updated_assoc = Repo.get(mod, assoc.id)
        {:ok, topic, updated_assoc}
    end
  end

  def get_module_name(atom) do
    case atom do
      :exercises -> StudyBuddy.Exercises.Exercise
      _ -> raise ArgumentError, "Module name for #{atom} not recognized"
    end
  end
end
