class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.where("title LIKE '%#{params[:q]}%'")
    render 'welcome/index'
    #redirect_to :root
  end

def create
  @task = Task.create(task_params)
  flash[:notice] = @task.errors.full_messages.to_sentence unless @task.valid?
  redirect_to :root
  #render 'welcome/index'
end

def destroy
  Task.delete(params[:id])
  redirect_to :root
end

def edit
  @task = Task.find(params[:id])
end

def update
  @task = Task.find(params[:id])
  if @task.update(task_params)
    redirect_to :root
  else
    #
  end
end

private

def task_params
  params.require(:task).permit(:title, :description, :status, :expire_at)
end
end
