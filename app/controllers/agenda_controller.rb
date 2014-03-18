class AgendaController < ApplicationController
  before_filter :authenticate_user!

  def index
    week
  end

  def week
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    dates = (start_date..start_date + 7.days)
    @happenings = {} 
    Task.all.each do |task|
      dates.each do |date|
        if task.schedule.exists? && task.schedule.occurs_on?(date)
          if (@happenings[date].nil?)
            @happenings[date] = Array.new()
          end
          @happenings[date].push(task)
        end
      end
    end 
  end
end
