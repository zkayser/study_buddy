defmodule StudyBuddy.CategoriesTest do
  use StudyBuddy.DataCase

  alias StudyBuddy.Categories
  alias StudyBuddy.Categories.Topic
  alias StudyBuddy.Categories.Category
  alias StudyBuddy.Accounts.User
  alias StudyBuddy.Repo

  @valid_cat_attrs %{name: "some name"}
  @update_cat_attrs %{name: "some updated name"}
  @registration %{email: "e@example.com", first_name: "Z", last_name: "K",
                  password: "password", username: "username"
                 }
  @invalid_cat_attrs %{name: nil}
  @valid_topic_attrs %{title: "some title"}
  @update_topic_attrs %{title: "some updated title"}
  @invalid_topic_attrs %{title: nil}
  @valid_exercise_attrs %{type: "flashcard", task: "remember this", answer: "okay", time_limit: 30_000, source: "Some book"}

  setup do
    {:ok, user} = StudyBuddy.Accounts.register_user(@registration)
    [user: user]
  end
  ###### TOP LEVEL HELPER FUNCTIONS #####

  def topic_fixture(attrs \\ %{}) do
    {:ok, topic} =
      attrs
      |> Enum.into(@valid_topic_attrs)
      |> Categories.create_topic()
    topic
  end

  def category_fixture(attrs \\ %{}, %{user_id: id}) do
    {:ok, category, _} =
      attrs
      |> Enum.into(@valid_cat_attrs)
      |> Categories.create_category(id)
    category
  end

  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      attrs
      |> Enum.into(@valid_exercise_attrs)
      |> StudyBuddy.Exercises.create_exercise()
    exercise
  end

  describe "categories" do

    test "list_categories/1 returns all categories for the given user", context do
      category_fixture(%{user_id: context[:user].id})
      assert Enum.all?(Categories.list_categories(context[:user].id), 
              fn elem -> elem.user_id == context[:user].id end)
    end

    test "get_category!/1 returns the category with given id", context do
      category = category_fixture(%{user_id: context[:user].id})
      assert Categories.get_category!(category.id).name == category.name
    end

    test "create_category/2 with valid data creates a category", context do
      assert {:ok, %Category{} = category, %User{}} = Categories.create_category(@valid_cat_attrs, context[:user].id)
      assert category.name == "some name"
      assert category.user_id == context[:user].id
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Categories.create_category(@invalid_cat_attrs)
    end

    test "update_category/2 with valid data updates the category", context do
      category = category_fixture(%{user_id: context[:user].id})
      assert {:ok, category} = Categories.update_category(category, @update_cat_attrs)
      assert %Category{} = category
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset", context do
      category = category_fixture(%{user_id: context[:user].id})
      assert {:error, %Ecto.Changeset{}} = Categories.update_category(category, @invalid_cat_attrs)
      assert category == Categories.get_category!(category.id) |> Repo.preload([:user])
    end

    test "delete_category/1 deletes the category", context do
      category = category_fixture(%{user_id: context[:user].id})
      assert {:ok, %Category{}} = Categories.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Categories.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset", context do
      category = category_fixture(%{user_id: context[:user].id})
      assert %Ecto.Changeset{} = Categories.change_category(category)
    end

    test "associate/2 with two %Category structs creates a category/subcategory association", context do
      category = category_fixture(%{user_id: context[:user].id})
      {:ok, subcategory, _user} = Categories.create_category(%{name: "some subcategory"}, context[:user].id)
      {:ok, category, subcategory} = Categories.associate(category, subcategory)
      category = Repo.preload(category, [:subcategories])
      assert subcategory.category_id == category.id
      assert is_list(category.subcategories)
    end

    test "associate/2 with a Category struct and a Topic struct creates a category/topic association", context do
      category = category_fixture(%{user_id: context[:user].id})
      topic = topic_fixture()
      {:ok, category, topic} = Categories.associate(category, topic)
      assert topic in category.topics
      assert topic.category_id == category.id
    end

    test "associate/2 with a Topic and Exercise struct creates a topic/exercise association" do
      topic = topic_fixture()
      exercise = exercise_fixture()
      {:ok, topic, exercise} = Categories.associate(topic, exercise)
      assert exercise in topic.exercises
      assert exercise.topic_id == topic.id
    end

    test "associate/2 returns {:error, _, _} when given an association that is not allowed on categories", context do
      not_allowed = %Ecto.Changeset{} # Need a struct that has nothing cannot be associated with categories; choosing Changeset
      cat = category_fixture(%{user_id: context[:user].id})
      {response, cat_struct, not_allowed_struct} = Categories.associate(cat, not_allowed)
      assert response == :error
      assert cat_struct == cat
      assert not_allowed_struct == not_allowed
    end
  end

  describe "topics" do

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Categories.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Categories.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Categories.create_topic(@valid_topic_attrs)
      assert topic.title == "some title"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Categories.create_topic(@invalid_topic_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, topic} = Categories.update_topic(topic, @update_topic_attrs)
      assert %Topic{} = topic
      assert topic.title == "some updated title"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Categories.update_topic(topic, @invalid_topic_attrs)
      assert topic == Categories.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Categories.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Categories.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Categories.change_topic(topic)
    end
  end
end
