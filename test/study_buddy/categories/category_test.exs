defmodule StudyBuddy.Categories.CategoryTest do
  use StudyBuddy.DataCase

  alias StudyBuddy.Categories
  alias StudyBuddy.Categories.Category
  alias StudyBuddy.Repo

  @valid_attrs %{name: "Some Category"}
  @invalid_attrs %{name: ""}
  @registration %{email: "e@example.com", first_name: "Z", last_name: "K", 
                  username: "username", password: "password"
                }

  setup do
    {:ok, user} = StudyBuddy.Accounts.register_user(@registration)

    [user: user]
  end

  def category_fixture(_attrs \\ %{}, user_id) do
    {:ok, category, _user} = Categories.create_category(@valid_attrs, user_id)
    category
  end

  describe "Category" do
    test "should exist", context do
      assert category_fixture(context[:user].id).name == "Some Category"
    end

    test "should return an invalid changeset if name is absent", context do
      {:error, changeset} = Categories.create_category(@invalid_attrs, context[:user].id)
      refute changeset.valid?
    end

    test "should be able to build and insert subcategory association with valid attributes", context do
      category = category_fixture(context[:user].id)
      {:ok, sub_cat} = build_assoc(category, :subcategories, [name: "Some subcategory"])
      |> Repo.insert()
      category = Repo.get!(Category, category.id) |> Repo.preload(:subcategories)
      assert sub_cat in category.subcategories
    end

    test "should return an invalid changeset when building a subcategory association with invalid attributes", context do
      category = category_fixture(context[:user].id)
      sub_cat = Category.build_subcategory(category, %Category{name: nil})
      refute sub_cat.valid?
    end

    test "build_subcategory should build a valid Category struct when given valid attributes", context do
      sub_cat = category_fixture(context[:user].id)
      |> Category.build_subcategory(%Category{name: "Some subcategory"})
      assert sub_cat.name == "Some subcategory"
      assert sub_cat.category_id
    end

    test "should be able to insert a valid subcategory into the database", context do
      {:ok, sub_cat} = category_fixture(context[:user].id)
      |> Category.build_subcategory(%Category{name: "Some subcategory"})
      |> StudyBuddy.Repo.insert()
      inserted = StudyBuddy.Repo.get(Category, sub_cat.id)
      assert inserted.id == sub_cat.id
      assert inserted.name == sub_cat.name
    end
  end
end
