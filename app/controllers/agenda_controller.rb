class AgendaController < ApplicationController
  def index
    week
  end

  def week
    dates = (Date.today..Date.today + 7.days)
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
