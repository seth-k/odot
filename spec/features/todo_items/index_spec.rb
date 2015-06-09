require 'spec_helper'

describe "Viewing todo items" do
  let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list.") }
  let(:user) {create(:user)}

  before do
    sign_in user, password: "treehouse1"
  end
  
  it "displays the title of the todo list" do
    visit_todo_list(todo_list)
    within("h1#title") do
      expect(page).to have_content(todo_list.title)
    end
  end
  
  it "displays no items when a todo list is empty" do
    visit_todo_list(todo_list)
    expect(page.all("table.todo_items tr").size).to eq(0)
  end
  
  it "displays item content when a todo list has items" do
    todo_list.todo_items.create(content: "Milk")
    todo_list.todo_items.create(content: "Eggs")
    visit_todo_list(todo_list)
    expect(page.all("table.todo_items tr").size).to eq(2)
    within "table.todo_items" do
      expect(page).to have_content("Milk")
      expect(page).to have_content("Eggs")
    end
  end
end