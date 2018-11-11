class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.where("title LIKE '%#{params[:search_query]}%'").order(id: :desc)
    render 'welcome/index'
  end

  def create
    @tasks = Task.where("title LIKE '%#{params[:search_query]}%'").order(id: :desc)
    @task = Task.create(task_params)
    render 'welcome/index'
  end

  def destroy
    Task.delete(params[:id])
    redirect_to :root
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :expire_at)
  end
end
