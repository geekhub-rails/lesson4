class TasksController < ApplicationController
  before_action :require_user

  def index
    @task = Task.new
    @tasks = current_user.tasks.q(params[:q]).paginate(:page => params[:page], :per_page => 10)
  end

  def create
    @task = current_user.tasks.create(task_params)
    return if @task.invalid?
    @task.save
    redirect_to :root
  end

  def update
    task.update(update_task_params)
    head 200
  end

  def destroy
    Task.delete(params[:id])
    redirect_to :root
  end

  private

  def task
    @task ||= current_user.tasks.find(params[:id])
  end

  def update_task_params
    params.require(:task).permit(:status)
  end

  def task_params
    params.require(:task).permit(:title, :description, :expire_at, :status)
  end
end
