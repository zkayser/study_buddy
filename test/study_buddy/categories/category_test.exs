defmodule StudyBuddy.Categories.CategoryTest do
  use StudyBuddy.DataCase

  alias StudyBuddy.Categories
  alias StudyBuddy.Categories.Category
  alias StudyBuddy.Repo

  @valid_attrs %{name: "Some Category"}
  @invalid_attrs %{name: ""}

  def category_fixture(_attrs \\ %{}) do
    {:ok, category} = Categories.create_category(@valid_attrs)
    category
  end

  describe "Category" do
    test "should exist" do
      assert category_fixture().name == "Some Category"
    end

    test "should return an invalid changeset if name is absent" do
      {:error, changeset} = Categories.create_category(@invalid_attrs)
      refute changeset.valid?
    end

    test "should be able to build and insert subcategory association with valid attributes" do
      category = category_fixture()
      {:ok, sub_cat} = build_assoc(category, :subcategories, [name: "Some subcategory"])
      |> Repo.insert()
      category = Repo.get!(Category, category.id) |> Repo.preload(:subcategories)
      assert sub_cat in category.subcategories
    end

    test "should return an invalid changeset when building a subcategory association with invalid attributes" do
      category = category_fixture()
      sub_cat = Category.build_subcategory(category, %{name: nil})
      refute sub_cat.valid?
    end

    test "build_subcategory should build a valid Category struct when given valid attributes" do
      sub_cat = category_fixture()
      |> Category.build_subcategory(%{name: "Some subcategory"})
      assert sub_cat.name == "Some subcategory"
      assert sub_cat.category_id
    end
  end
end
