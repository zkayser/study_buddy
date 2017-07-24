defmodule StudyBuddy.Categories do
  @moduledoc """
  The boundary for the Categories system.
  """

  import Ecto.Query, warn: false
  alias StudyBuddy.Repo

  alias StudyBuddy.Categories.Category
  alias StudyBuddy.Categories.Topic
  alias StudyBuddy.Exercises.Exercise

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{source: %Category{}}

  """
  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end

  ## TODO Complete the associate/2 implementation and provide examples in docs
  @doc """
    The associate/2 functions examine the type of structs passed in
    and return {:ok, updated_struct1, updated_struct2} when the
    association is successful and both structs are appropriately
    updated in the database.

    Associatable structs are as follows:
    associate(%Category{} = category, %Category{} = subcategory)
    associate(%Category{} = subcategory, %Topic{} = topic)
    associate(%Topic{} = topic, %Category{} = subcategory)

    Calls to associate/2 with any other combination of structs will return
    {:error, unchanged_param1, unchanged_param2}. The same tuple will be
    returned if either or both structs fail to be persisted to the database

    Note that the associate(category, subcategory) call must have the params
    in a specific order where the first param is the parent category and
    the second param is the subcategory. The associate/2 call to link
    a topic with a subcategory can be made with the params in either order for convenience.

  """

  def associate(%Category{} = category, %Category{} = subcategory) do
    Category.build_relation(:subcategories, category, subcategory)
  end

  def associate(%Category{} = subcategory, %Topic{} = topic) do
    Category.build_relation(:topics, subcategory, topic)
  end

  def associate(%Topic{} = topic, %Category{} = subcategory) do
    Category.build_relation(:topics, subcategory, topic)
  end

  def associate(%Topic{} = topic, %Exercise{} = exercise) do
    Topic.build_relation(:exercises, topic, exercise)
  end

  def associate(param1, param2), do: {:error, param1, param2}

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Repo.all(Topic)
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic!(id), do: Repo.get!(Topic, id)

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{source: %Topic{}}

  """
  def change_topic(%Topic{} = topic) do
    Topic.changeset(topic, %{})
  end
end
