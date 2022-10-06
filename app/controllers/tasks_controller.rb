class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: %i[show edit update destroy]

  # GET /project/1/tasks or /tasks.json
  def index
    @tasks = Task.where(project: @project)
  end

  # GET /project/1/tasks/1 or /project/1/tasks/1.json
  def show
  end

  # GET /project/1/tasks/new
  def new
    @task = Task.new(project: @project)
  end

  # GET /project/1/tasks/1/edit
  def edit
  end

  # POST /project/1/tasks or /project/1/tasks.json
  def create
    @task = Task.new(task_params.merge(project: @project))

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project/1/tasks/1 or /project/1/tasks/1.json
  def update
    raise
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_tasks_url, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project/1/tasks/1 or /project/1/tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to project_url(@project.id), notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:name, :description, :project_id, :member_id, :status)
  end
end
