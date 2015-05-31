require 'spec_helper'
RSpec.configure do |c|
  c.expose_current_running_example_as :example
end

describe "Editing todo items" do
  let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list.") }
  let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }
 
  it "successful when marking a single item compete" do
    expect(todo_item.completed_at).to be_nil
    visit_todo_list todo_list
    within dom_id_for(todo_item) do
      click_link "Mark Complete"
    end
    todo_item.reload
    expect(todo_item.completed_at).to_not be_nil
  end

end