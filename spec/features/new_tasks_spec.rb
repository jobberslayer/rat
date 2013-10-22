require 'spec_helper'

describe "NewTasks", type: :feature do
  it "load new task form" do
    visit new_task_path

  end
end
