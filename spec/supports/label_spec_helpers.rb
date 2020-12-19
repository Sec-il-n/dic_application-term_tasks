module LabelSpecHelpers
  def create_own_label
    visit new_label_path
    fill_in "#{I18n.t('.labels.show.label name')}", with: '自作ラベル'
    find(:xpath,'/html/body/div/div/div/form/div[2]/input[2]').click
  end
end
