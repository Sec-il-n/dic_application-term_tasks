module UserSpecHelpers
  def login_as_user
      #切り出し
      user = FactoryBot.create(:user)
      visit new_session_path
      fill_in "#{I18n.t('.dictionary.words.email')}", with: user.email
      fill_in "#{I18n.t('.dictionary.words.password')}", with: user.password
      click_button "#{I18n.t('.dictionary.words.login')}"
  end
  # インスタンス　引数　✖︎？
  # def login_as_user(user)
  #     visit new_session_path
  #     fill_in "#{I18n.t('.dictionary.words.email')}", with: user.email
  #     fill_in "#{I18n.t('.dictionary.words.password')}", with: user.password
  #     click_button "#{I18n.t('.dictionary.words.login')}"
  # end
end
