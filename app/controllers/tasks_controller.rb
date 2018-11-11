class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.where("title LIKE '%#{params[:search_query]}%'")
    render 'welcome/index'
  end

  def create
    @task = Task.create(task_params)
    redirect_to :root
  end

  def destroy
    Task.delete(params[:id])
    redirect_to :root
  end

  private

  def task_params
    params.require(:task).permit(:title)
  end
end
