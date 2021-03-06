defmodule StudyBuddy.Categories.TopicTest do
  use StudyBuddy.DataCase

  alias StudyBuddy.Categories

  @valid_attrs %{title: "some title"}
  @invalid_attrs %{title: nil}
  @registration %{email: "e@example.com", username: "username",
                  password: "password", first_name: "Z", last_name: "K"
                 }

  setup do
    {:ok, user} = StudyBuddy.Accounts.register_user(@registration)

    [user: user]
  end

  def topic_fixture(_attrs \\ %{}) do
    {:ok, topic} = Categories.create_topic(@valid_attrs)
    topic
  end

  describe "Topic" do
    test "should create a topic with valid attributes" do
      assert topic_fixture().title == "some title"
    end

    test "should not create a topic with invalid attributes" do
      {_, bad_topic} = Categories.create_topic(@invalid_attrs)
      refute bad_topic.valid?
      assert "can't be blank" in errors_on(bad_topic).title
    end

    test "should be able to associate a topic with a category", context do
      topic = topic_fixture()
      {:ok, category, _user} = Categories.create_category(%{name: "some category"}, context[:user].id)
      {:ok, updated_category, updated_topic} = Categories.associate(category, topic)
      assert updated_topic.category_id == updated_category.id
    end
  end
end
