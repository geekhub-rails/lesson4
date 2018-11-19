module TasksHelper
  def task_class(status)
    status == 'done' ? 'alert-success' : 'alert-secondary'
  end
end
