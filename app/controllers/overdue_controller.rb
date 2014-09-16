class OverdueController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.find(:all, order: 'last_name, first_name')
    @overdue_tasks = [] 
    @users.each do |u|
      Task.where(user_id: u.id).each do |t|
        t.schedule.all_overdue.each do |date|
          @overdue_tasks.push([t, date])
        end
      end 
      Status.where(user_id: u.id).each do |t|
        t.schedule.all_overdue.each do |date|
          @overdue_tasks.push([t, date])
        end
      end
    end 
    @overdue_tasks = @overdue_tasks.paginate(page: params[:page], per_page: 20, count: @overdue_tasks.size)
  end
end
