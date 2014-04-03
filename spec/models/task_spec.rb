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

      c = Status.find(child.id)
      c.task_id.should be parent.id
      c.schedule.id.should be child_s.id

      s2 = Schedule.find(s.id)
      s2.id.should be s.id

      parent.destroy
      Task.should_not be_exists(parent.id)
      Status.should_not be_exists(child.id)

      Schedule.should_not be_exists(s.id)
      Schedule.should_not be_exists(child_s.id)
    end
  end

  describe "testing overdue" do
    it do
      c = FactoryGirl.create(:company)
      g = FactoryGirl.create(:category)
      u = FactoryGirl.create(:normal_user, first_name: 'Test', last_name: 'User', email: 'user@test.org')
      s = FactoryGirl.create(:schedule)

      t = FactoryGirl.create(:task, company: c, user: u, category: g, schedule: s) 
      t.save

      t.schedule.kind = 'last_day_month'
      t.save

      t.schedule.all_overdue(Date.today + 1.month).length.should == 1

      t.schedule.all_overdue(Date.today + 1.month).each do |o|
        t.schedule.log_date(o)
      end

      t.schedule.all_overdue(Date.today + 1.month).length.should eq 0

      t.schedule.histories.length.should eq 1

    end
  end
end
