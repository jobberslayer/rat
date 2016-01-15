class GlanceController < ApplicationController
  before_filter :authenticate_user!

  def index
    @companies = current_user.companies_with_tasks
    @current_company = params[:company_id].nil? ? @companies[0] : Company.find(params[:company_id])
    @tasks = current_user.tasks_for_company(@current_company.id).sort { |a,b| a.title <=> b.title }
    @task = params[:task_id].nil? ? @tasks[0] : Task.find(params[:task_id])
  end

  def task_info
    @task = Task.find(params[:task_id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def task_list
    @companies = current_user.companies_with_tasks
    @current_company = Company.find(params[:company_id])
    @companies.delete(@current_company)
    @companies.unshift @current_company
    @tasks = current_user.tasks_for_company(params[:company_id]).sort { |a,b| a.title <=> b.title }
    @task = @tasks[0]

    respond_to do |format|
      format.html
      format.js
    end
  end
end
