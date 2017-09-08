defmodule StudyBuddyWeb.CategoryView do
  use StudyBuddyWeb, :view
  alias StudyBuddyWeb.CategoryView
  alias StudyBuddyWeb.TopicView

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, CategoryView, "category.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    case length(category.subcategories) do
      0 -> 
        %{name: category.name,
          id: category.id
         }
      _ -> 
        %{name: category.name,
          id: category.id,
          subcategories: render_many(category.subcategories, CategoryView, "subcategory.json")
         }
    end
  end

  def render("subcategory.json", %{category: subcategory}) do
    case length(subcategory.topics) do
      0 -> 
        %{name: subcategory.name,
          id: subcategory.id
         }
      _ ->
        %{name: subcategory.name,
          id: subcategory.id,
          topics: render_many(subcategory.topics, TopicView, "topic.json")
         }
    end
  end
end
