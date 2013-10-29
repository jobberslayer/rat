require 'spec_helper'

describe Task do
  describe "create parent and children and delete" do
    it do
      c = Company.new(name: 'Test Company')
      u = User.new(first_name: 'Test', last_name: 'User', email: 'user@test.org', password: 'password', password_confirmation: 'password')
      s = Schedule.new() 
      parent = Task.new(user_id: u.id, company_id: c.id, title: "Parent Task", info: "This is the parent task.")
      parent.schedule = s
      parent.save
      s.save

      child = Task.new(user_id: u.id, company_id: c.id, title: "subtask", info:'this is a subtask.')
      child_s = Schedule.new()
      child.schedule = child_s
      child.save
      child.move_to_child_of(parent) 

      c = Task.find(child.id)
      c.parent_id.should be parent.id
      c.schedule.id.should be child_s.id

      s2 = Schedule.find(s.id)
      s2.id.should be s.id

      parent.destroy
      Task.should_not be_exists(parent.id)
      Task.should_not be_exists(child.id)

      Schedule.should_not be_exists(s.id)
      Schedule.should_not be_exists(child_s.id)
    end
  end
end