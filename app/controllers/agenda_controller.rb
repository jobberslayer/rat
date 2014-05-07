class AgendaController < ApplicationController
  before_filter :authenticate_user!

  def index
    @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    @happenings = {} 
    increment = 14
    @year_of_nothing = false

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
        @show_team = params[:agenda][:view_team]
      else
        @show_company = ''
        @show_team = ''
      end

      if current_user.admin? && @show_user.blank?
        tasks = Task.joins(:user).joins(:company)
        statuses = Status.joins(:user).joins(:task).joins('LEFT OUTER JOIN companies ON tasks.company_id = companies.id ')
        if !@show_company.blank?
          tasks = tasks.where("companies.id = ?", @show_company)
          statuses = statuses.where("companies_id=?", @show_company)
        end
        if !@show_team.blank?
          tasks = tasks.where("companies.team_id = ?", @show_team)
          statuses = statuses.where("companies.team_id = ?", @show_team)
        end
        tasks = tasks.order('users.last_name', 'users.first_name','companies.name')
        statuses = statuses.order('users.last_name', 'users.first_name','companies.name')
      else
        tasks = Task.joins(:company).where("user_id = #{@show_user}")
        statuses = Status.joins(:task).joins('LEFT OUTER JOIN companies ON tasks.company_id = companies.id ').where("statuses.user_id = #{@show_user}")
        if !@show_company.blank?
          tasks = tasks.where("companies.id = ?", @show_company)
          statuses = statuses.where("companies.id = ?", @show_company)
        end
        if !@show_team.blank?
          statuses = statuses.where("companies.team_id = ?", @show_team)
        end
        tasks = tasks.order('companies.name')
        statuses = statuses.order('companies.name')
      end

      tasks.each do |task|
        dates.each do |date|
          if task.schedule.exists? && task.schedule.occurs_on?(date)
            if (@happenings[date].nil?)
              @happenings[date] = Array.new()
            end
            @happenings[date].push(task)
          end
        end
      end

      statuses.each do |task|
        dates.each do |date|
          if task.schedule.exists? && task.schedule.occurs_on?(date)
            if (@happenings[date].nil?)
              @happenings[date] = Array.new()
            end
            @happenings[date].push(task)
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
