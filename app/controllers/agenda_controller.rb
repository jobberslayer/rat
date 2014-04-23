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
      if current_user.admin? && params[:agenda]
        @show_user = params[:agenda][:view_user] || current_user.id
      else
        @show_user = current_user.id
      end

      if params[:agenda]
        @show_company = params[:agenda][:view_company]
      else
        @show_company = ''
      end

      if current_user.admin? && @show_user.blank?
        tasks = Task.joins(:user).joins(:company)
        if !@show_company.blank?
          tasks = tasks.where("companies.id = ?", @show_company)
        end
        tasks = tasks.order('users.last_name', 'users.first_name','companies.name')
      else
        tasks = Task.joins(:company).where("user_id = #{@show_user}")
        if !@show_company.blank?
          tasks = tasks.where("companies.id = ?", @show_company)
        end
        tasks = tasks.order('companies.name')
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
