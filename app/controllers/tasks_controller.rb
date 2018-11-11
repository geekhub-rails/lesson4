class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = tasks
    render 'welcome/index'
  end

  def create
    @tasks = tasks
    @task = Task.create(task_params)
    render 'welcome/index'
  end

  def update
    @tasks = tasks
    @task = Task.find(params[:id])
    @task.update(status: @task.status == 'done' ? 'active' : 'done')

    render 'welcome/index'
  end

  def destroy
    Task.delete(params[:id])
    redirect_to :root
  end

  private

  def tasks
    Task.where("title LIKE '%#{params[:search_query]}%'").order(id: :desc)
  end

  def task_params
    params
      .require(:task)
      .permit(:title, :description, :expire_at, :status)
      .reverse_merge(status: 'active')
  end
end
