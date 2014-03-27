class TasksController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource #CanCan validation hook
  
  # GET /tasks
  # GET /tasks.json
  def index
    if params[:user_id].nil?
      params[:user_id] = current_user.id.to_s
    end

    @tasks = Task
        .filters(params)
        .order('companies.name', 'categories.name', 'tasks.created_at')
        .paginate(page: params[:page], per_page: 10, :count => {:group => 'tasks.id' })

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    @subtasks = @task.statuses.order(:created_at).reverse
    @subtask = Status.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
    @task.build_schedule
    @task.statuses.build
    @task.user_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
      format.js
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.js
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html do 
          redirect_to @task, notice: 'Task was successfully created.'
        end
        format.json { render json: @task, status: :created, location: @task }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html do 
        redirect_to tasks_url
      end

      format.json { head :no_content }
      format.js
    end
  end

  def new_status
    @task_id = params[:id]
    @task = Task.find(@task_id)
    @status = Status.new()
    @status.build_schedule

    respond_to do |format|
      format.js
    end
  end

  def create_status
    task_id = params[:id]
    @task = Task.find(task_id)
    @status = Status.new(params[:status])
    
    if @status.save
      flash.now[:success] = "Prayer update created."
    else
      flash.now[:error] = "Errors below."
    end

    @task.statuses.push @status

    respond_to do |format|
      format.js
    end
  end

  def edit_status
    @task = Task.find(params[:id])
    @status = Status.find(params[:status_id])
  end

  def update_status
    @task = Task.find(params[:id])
    @status = Status.find(params[:status_id])

    if @status.update_attributes(params[:status])
      flash[:success] = "Request updated."
    else
      flash.now[:error] = "Errors below."
    end

    respond_to do |format|
      format.js 
    end
  end

end
