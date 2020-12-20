require 'rails_helper'
RSpec.describe User, type: :system do
  describe'ユーザー管理機能'do
    it 'ユーザーの新規登録ができる。'do
      name = 'tester'
      email = 'tester@hoge.com'
      password = 'password'
      visit new_user_path
      fill_in "#{I18n.t('.dictionary.words.user_name')}", with: name
      fill_in "#{I18n.t('.dictionary.words.email')}", with: email
      fill_in "#{I18n.t('.dictionary.words.password')}", with: password
      fill_in "#{I18n.t('.dictionary.words.password_confirmation')}", with: password
      click_button "#{I18n.t('.dictionary.words.submit')}"
      expect(page).to have_content("#{I18n.t('dictionary.words.user created')}")
    end
    context'ユーザがログインせずタスク一覧画面に飛ぼうとした場合'do
      it'ログイン画面に遷移する'do
        visit tasks_path
        expect(page).to have_content("#{I18n.t('.tasks.index.need loggedin')}")
        expect(page).to have_content("#{I18n.t('.dictionary.words.login')}")
      end
    end
  end
  describe'セッション管理機能'do
    it 'ログインできる'do
      login_as_user
      expect(page).to have_content("#{I18n.t('.dictionary.words.logged in')}")
    end
    it '自分の詳細画面に飛べる。'do
      user = FactoryBot.create(:user)
      visit new_session_path
      fill_in "#{I18n.t('.dictionary.words.email')}", with: user.email
      fill_in "#{I18n.t('.dictionary.words.password')}", with: user.password
      click_button "#{I18n.t('.dictionary.words.login')}"
      visit user_path(user.id)
      expect(page).to have_content(user.user_name)
      expect(page).to have_content(user.email)
    end
    context'一般ユーザが他人の詳細画面にアクセスした場合'do
      # let user
      it 'タスク一覧画面に遷移する'do
        user_1 = FactoryBot.create(:user)
        user_2 = FactoryBot.create(:user_2)
        visit new_session_path
        fill_in "#{I18n.t('.dictionary.words.email')}", with: user_2.email
        fill_in "#{I18n.t('.dictionary.words.password')}", with: user_2.password
        click_button "#{I18n.t('.dictionary.words.login')}"
        visit user_path(user_1.id)

        expect(find(:xpath, '/html/body/div/div/h1')).to have_content("#{I18n.t('.tasks.index.title')}")
        expect(page).to have_content("#{I18n.t('dictionary.words.cannot see other details')}")
      end
      it 'ログアウトができる。'do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in "#{I18n.t('.dictionary.words.email')}", with: user.email
        fill_in "#{I18n.t('.dictionary.words.password')}", with: user.password
        click_button "#{I18n.t('.dictionary.words.login')}"
        click_on "#{I18n.t('.layouts.header.logout')}"

        expect(page).to have_content("#{I18n.t('.dictionary.words.logged out')}")
      end
    end
  end
end
