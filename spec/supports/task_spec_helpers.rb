module TaskSpecHelpers
  def converter(priority)
    # priority.map { |string| string.converter }
    if priority == '高'
      2
    elsif priority == '中'
      1
    elsif priority == '低'
      0
    end
  end

  # def fill_in_form
    # visit new_task_path
    # fill_in 'タスク名', with: 'task_name'
    # fill_in '詳細', with: 'task_details'
    # fill_in '終了期限', with: '002020-12-18'
    # find('#task_status').find(:xpath, 'option[3]').select_option
  # end
end
