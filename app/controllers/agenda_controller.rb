class AgendaController < ApplicationController
  before_filter :authenticate_user!

  def index
    @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    @happenings = {} 
    increment = 14
    @year_of_nothing = false
    @show_all = params[:show_all] || false
    while @happenings.empty?
      @end_date = @start_date + increment.days
      dates = (@start_date..@end_date)
      
      tasks = nil
      if current_user.admin? && params[:show_all]
        tasks = Task.joins(:user).joins(:company).order('users.last_name', 'users.first_name','companies.name')
      else
        tasks = Task.joins(:company).where("user_id = #{current_user.id}").order('companies.name')
      end

      tasks.each do |task|
        dates.each do |date|
          if task.schedule.exists? && task.schedule.occurs_on?(date)
            if (@happenings[date].nil?)
              @happenings[date] = Array.new()
            end
            @happenings[date].push(task)
          end
          task.statuses.each do |status|
            if status.schedule.exists? && status.schedule.occurs_on?(date)
              if (@happenings[date].nil?)
                @happenings[date] = Array.new()
              end
              @happenings[date].push(status)
            end
          end
        end
      end

      increment += 7
      if increment > (52 * 7)
        @year_of_nothing = true
        break
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
