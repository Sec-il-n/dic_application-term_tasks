# 12/8途中　注意　検索等モデルを通じて取得する→modelSpec, fill_inして操作する→System
require 'rails_helper'
RSpec.describe User, type: :system do
  describe '管理画面のテスト'do
    context'管理ユーザが管理画面にアクセスした場合'do
      it '管理画面が表示される' do
        admin = FactoryBot.create(:admin)
        # 切り出し　管理者ログイン
        visit new_session_path
        fill_in "#{I18n.t('.dictionary.words.email')}", with: admin.email
        fill_in "#{I18n.t('.dictionary.words.password')}", with: admin.password
        click_button "#{I18n.t('.dictionary.words.login')}"
        visit admin_users_path
        # binding.pry
        expect(find(:xpath, '/html/body/div/div/h1')).to have_content("#{I18n.t('.dictionary.words.admin')}")
      end
    end
    context '一般ユーザが管理画面にアクセスした場合'do
        it 'タスク一覧画面へ遷移する'do
          user = FactoryBot.create(:admin, admin: false)
          visit new_session_path
          fill_in "#{I18n.t('.dictionary.words.email')}", with: user.email
          fill_in "#{I18n.t('.dictionary.words.password')}", with: user.password
          click_button "#{I18n.t('.dictionary.words.login')}"
          visit admin_users_path
          expect(find(:xpath, '/html/body/div/div/h1')).to have_content("#{I18n.t('.tasks.index.title')}")
        end
    end
    it '管理ユーザはユーザの新規登録ができる'do
      name = 'tester-1'
      email = 'tester-1@hoge.com'
      password = 'password'
      # 管理者としてログインする　切り出し
      admin = FactoryBot.create(:admin)
      visit new_session_path
      fill_in "#{I18n.t('.dictionary.words.email')}", with: admin.email
      fill_in "#{I18n.t('.dictionary.words.password')}", with: admin.password
      click_button "#{I18n.t('.dictionary.words.login')}"
      visit new_admin_user_path
      fill_in "#{I18n.t('.dictionary.words.user_name')}", with: name
      fill_in "#{I18n.t('.dictionary.words.email')}", with: email
      fill_in "#{I18n.t('.dictionary.words.password')}", with: password
      fill_in "#{I18n.t('.dictionary.words.password_confirmation')}", with: password
      click_button "#{I18n.t('.dictionary.words.submit')}"
      expect(page).to have_content( "#{I18n.t('.dictionary.words.user created')}")
    end

    let(:elements) { all('#admin_show') }
    # let(:elements) { all(:xpath, '/html/body/div/div/table/tbody/tr[2]/td[3]/a') }
    it '管理ユーザはユーザの詳細画面にアクセスできる'do
      user = FactoryBot.create(:admin, user_name: 'user', email:'user@hoge.com', admin: false)
      # 管理者としてログインする　切り出し
      admin = FactoryBot.create(:admin)
      visit new_session_path
      fill_in "#{I18n.t('.dictionary.words.email')}", with: admin.email
      fill_in "#{I18n.t('.dictionary.words.password')}", with: admin.password
      click_button "#{I18n.t('.dictionary.words.login')}"
      visit admin_users_path

      elements.each do |element|
        element.click
        # click_on(element)　# Capybara::ElementNotFound:
        # click_on(element.text) 複数存在エラー
        # expect(URI.parse(current_url).path).to eq(admin_users_path(user.id))
        expect(URI.parse(current_url).path).to eq(admin_users_path + '/' + user.id.to_s)
      end
      # click_on(first(find('詳細')))
      # click_on(find(:xpath, '/html/body/div/div/table/tbody/tr[2]/td[3]/a'))
      # click_link(find_by_id('#admin_show'))
      # expect(current_url).to eq(admin_users_path(user.id))
    end

    let(:elements_edit) { all('#admin_edit') }
    it '管理ユーザはユーザの編集画面からユーザを編集できる' do
      # 切り出し
      user = FactoryBot.create(:admin, user_name: 'user', email:'user@hoge.com', admin: false)
      # 管理者としてログインする　切り出し
      admin = FactoryBot.create(:admin)
      visit new_session_path
      fill_in "#{I18n.t('.dictionary.words.email')}", with: admin.email
      fill_in "#{I18n.t('.dictionary.words.password')}", with: admin.password
      click_button "#{I18n.t('.dictionary.words.login')}"
      visit admin_users_path

      elements_edit.each do |e|
        e.click
        fill_in "#{I18n.t('.dictionary.words.user_name')}", with: 'name_edit'
        fill_in "#{I18n.t('.dictionary.words.email')}", with: "name_edit@hoge.com"
        fill_in "#{I18n.t('.dictionary.words.password')}", with: 'password'
        fill_in "#{I18n.t('.dictionary.words.password_confirmation')}", with: 'password'
        # binding.pry
        click_on "#{I18n.t('.dictionary.words.register')}"
        expect(page).to have_content("#{I18n.t('.admin.users.index.editted user')}")
      end
    end

    let(:elements_delete) { all('#admin_delete') }
    it '管理ユーザはユーザの削除ができる'do
      # 問題：要素をひとつ取り出して操作する(<a>の集合に対し)ができないので、admin=true
      # を２人作成して削除している。（ひとりになると引っかかり、同じ検証ができないため。）
      user = FactoryBot.create(:admin, user_name: 'user', email:'user@hoge.com', admin: true)
      admin = FactoryBot.create(:admin)
      visit new_session_path
      fill_in "#{I18n.t('.dictionary.words.email')}", with: admin.email
      fill_in "#{I18n.t('.dictionary.words.password')}", with: admin.password
      click_button "#{I18n.t('.dictionary.words.login')}"
      visit admin_users_path

      elements_delete.each do |d|
        d.click
        expect(page).to have_content("#{I18n.t('.admin.users.index.user deleted')}")
      end
    end
  end
end
