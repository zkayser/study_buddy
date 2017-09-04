defmodule StudyBuddyWeb.CategoryViewTest do
	use StudyBuddyWeb.ConnCase, async: true

	alias StudyBuddyWeb.CategoryView
	alias StudyBuddy.Categories.Category

	@subcategories for x <- 5..10, do: %Category{name: "My subcategory #{x}", id: x, topics: []}
	@expected_subcategories_json for x <- 5..10, do: %{name: "My subcategory #{x}", id: x}
	@expected_json_multi for x <- 1..4, do: %{name: "Main category", id: x}

	def category_fixture do
		%Category{name: "My category", id: 1, subcategories: []}
	end

	def category_with_subcategories(main_category_id) do
		%Category{name: "Main category", id: main_category_id, subcategories: @subcategories}
	end

	def multiple_categories do
		for x <- 1..4 do
			category_with_subcategories(x)
		end
	end

	def expected_response_for_multi do
		%{data: Enum.map(@expected_json_multi, &Map.put(&1, :subcategories, @expected_subcategories_json))}
	end

	test "renders a single category" do
		result = CategoryView.render("show.json", %{category: category_fixture()})
		assert result == %{data: %{
												name: "My category",
											 	id: 1}
											 }
	end

	test "renders_a_category_with_subcategories" do
		result = CategoryView.render("show.json", %{category: category_with_subcategories(1)})
		assert result == 
			%{data: 
				%{name: "Main category",
					id: 1,
					subcategories: @expected_subcategories_json
				}
			}
	end

	test "index/2 renders multiple categories with multiple subcategories" do
		result = CategoryView.render("index.json", %{categories: multiple_categories()})
		assert result == expected_response_for_multi()
	end
end