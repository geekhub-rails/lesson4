class TasksController < ApplicationController
  before_action :require_user

  def index
    @task = Task.new
    @user = User.find_by(id: params[:user_id])
    shared = @user && JSON.parse(@user.shared)
    if shared.kind_of?(Array) && shared.include?(current_user.id)
      @tasks = Task.for_dashboard(params).where(user_id: @user.id)
    else
      @tasks = Task.for_dashboard(params).where(user_id: current_user)
    end
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

  def share
    @user = User.find_by(name: share_users_tasks_params[:name])
    shared = current_user.shared && JSON.parse(current_user.shared)
    if shared.kind_of?(Array)
      shared.push(@user.id)
      current_user.shared = shared
    else
      current_user.shared = [@user.id]
    end
    current_user.save
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

  def share_users_tasks_params
    params.permit(:name)
  end
end
