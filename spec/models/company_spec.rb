require 'spec_helper'

describe Task do
  describe "create parent and children and delete" do
    it do
      c = FactoryGirl.create(:company)
      u = FactoryGirl.create(:normal_user, first_name: 'Test', last_name: 'User', email: 'user@test.org')
      s = FactoryGirl.create(:schedule)
      g = FactoryGirl.create(:category)
      parent = FactoryGirl.create(:task, company: c, user: u, schedule: s, category: g) 
      parent.schedule = s
      parent.save
      s.save

      child = FactoryGirl.create(:status)
      child_s = Schedule.new()
      child.schedule = child_s
      child.save
      parent.statuses.push child

      s = Status.find(child.id)
      s.task_id.should be parent.id
      s.schedule.id.should be child_s.id

      s2 = Schedule.find(s.id)
      s2.id.should be s.id

      c.destroy
      Task.should_not be_exists(parent.id)
      Status.should_not be_exists(child.id)

      Schedule.should_not be_exists(s.id)
      Schedule.should_not be_exists(child_s.id)
    end
  end
end  

