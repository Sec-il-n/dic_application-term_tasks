module TasksHelper
  def choose_path
    if action_name == 'edit'|| action_name == 'update'
    # if action_name == 'update'
      task_path
    elsif action_name == 'create'
      tasks_path
    end
  end
end
