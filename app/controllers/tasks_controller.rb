class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.filters(params).joins(:company).joins(:category).order('companies.name', 'categories.name', 'created_at').roots.paginate(page: params[:page], per_page: 10)
    #@tasks = Task.joins(:company).filters(params).order('category_id').paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    @subtasks = @task.children.order(:created_at).reverse
    @subtask = Task.new

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

    @parent = nil
    if params[:task_id]
      @parent = Task.find(params[:task_id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
      format.js
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @parent = @task.parent

    respond_to do |format|
      format.html # edit.html.erb
      format.js
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    parent = nil

    if params[:task][:child_of_id]
      parent = Task.find(params[:task][:child_of_id])    
      params[:task].delete :child_of_id
    end

    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        if parent
          @task.move_to_child_of(parent)
        end
        format.html do 
          if parent
            redirect_to parent, notice: 'Subtask was successfully created.'
          else
            redirect_to @task, notice: 'Task was successfully created.'
          end
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
    if params[:task][:child_of_id]
      parent = Task.find(params[:task][:child_of_id])    
      params[:task].delete :child_of_id
    end

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
    parent = @task.parent
    @task.destroy

    respond_to do |format|
      format.html do 
        if parent
          redirect_to task_url parent
        else
          redirect_to tasks_url
        end
      end

      format.json { head :no_content }
      format.js
    end
  end
end
