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
end
