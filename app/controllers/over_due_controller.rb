class OverDueController < ApplicationController
  def index
    @users = User.find(:all, order: 'last_name, first_name')
    @overdue_tasks = [] 
    @users.each do |u|
      Task.where(user_id: u.id).each do |t|
        if t.schedule.all_overdue().count > 0
          @overdue_tasks.push(t)
        end 
        if !t.statuses.nil?
          t.statuses.each do |s|
            if s.schedule.all_overdue().count > 0
              @overdue_tasks.push(s)
            end
          end
        end
      end
    end 

  end
end
