require 'rails_helper'
require 'active_support/time'
require 'date'
RSpec.describe Task, type: :system do
  describe 'タスク管理機能' do
    context 'タスクを新規作成したとき' do
      it '作成したタスクが画面に表示される' do
        login_as_user
        visit new_task_path
        fill_in 'タスク名', with: 'task_name'
        fill_in '詳細', with: 'task_details'
        fill_in '終了期限', with: '002022-12-18'
        # step3で修正
        find('#task_status').find(:xpath, 'option[3]').select_option
        click_button '登録する'
        expect(page).to have_content('task_name')
        expect(page).to have_content('task_details')
        expect(page).to have_content('2022/12/18')
        expect(page).to have_content('着手中')
      end
    end
    describe '一覧表示機能' do
      let(:user) { build(:user_1) }
      let(:tasks) { all('tbody #sequence') }
      let(:desc) { all('#sequence #created_at') }
      context '一覧画面に遷移した場合' do
        it '作成済みのタスク一覧が表示される' do
          login_as_user_with_association(user)
          visit tasks_path
          expect(tasks.count).to be 5
        end
      end
      context '一覧画面表示されたとき' do
        let(:user) { build(:user_1, :use_task_4) }
        it '作成日時の降順で表示される' do
          login_as_user_with_association(user)
          visit tasks_path
          # created_atは上書き不可
          task = Task.limit(5).recent
          task_list = all('#sequence #task_name')
          for i in 0..4
            expect(task_list[i].text).to have_content(task[i].task_name)
          end
        end
      end
    end
    describe '検索機能' do
      let(:user) { build(:user_1) }
      context 'タイトルで曖昧検索した場合' do
        it 'タイトルを含むタスクの一覧が表示される' do
          login_as_user
          visit tasks_path
          fill_in :task_name, with: 'タスク'
          click_button I18n.t('.dictionary.words.search')
          expect(page).to have_content('タスク')
        end
      end
      context 'ステータスで検索した場合' do
        it '指定したステータスのタスク一覧が表示される' do
          login_as_user_with_association(user)
          visit tasks_path
          #プルダウンでオプション２「着手中」を選択
          find('#status').find(:xpath, 'option[3]').select_option
          click_button "#{I18n.t('.dictionary.words.search')}"
          elements = all(:xpath, '//*[@id="status_shown"]')
          elements.count.times do |n|
            expect(elements[n].text).to eq "#{I18n.t('.dictionary.words.Already started')}"
          end
        end
      end
      context 'タイトルとステータスで検索した場合' do
        let(:user) { build(:user_1, :use_task_4) }
        it 'タイトルを含み指定したステータスのタスクの一覧が表示される' do
          login_as_user_with_association(user)
          visit tasks_path
          fill_in :task_name, with: 'タスク6'
          find('#status').find(:xpath, 'option[1]').select_option
          click_button("#{I18n.t('.dictionary.words.search')}")
          # have_content は要素に指定できるが、eq be などは要素の文字列を取得する必要がある。
          expect(find('#sequence #task_name').text).to eq('タスク6')
        end
      end
    end
    describe '並べ替え機能'do
      let(:user) { build(:user_1) }
      let(:user_2) { build(:user_1, :use_task_3) }
      context '終了期限のリンクをクリックした場合'do
        let(:elements_valid) { all(:xpath, '//*[@id="valid_shown"]') }
        let(:valid_orderd) { Task.order_valid.map { |t| t.valid_date } }
        it '終了期限の昇順に表示される'do
          login_as_user_with_association(user)
          visit  tasks_path
          click_link "#{I18n.t('.dictionary.words.valid_date')}"
          elements_valid.count.times do |n|
            expect(elements_valid[n].text).to eq valid_orderd[n].strftime('%Y/%m/%d')
          end
        end
      end
      context '優先順位のリンクをクリックした場合'do
        let(:elements) { all(:xpath, '//*[@id="priority_shown"]') }
        let(:priority_orderd) { Task.order_priority.map { |t| t.priority_before_type_cast } }
        it '優先順位の高いものから順に表示される'do
          login_as_user_with_association(user_2)
          visit tasks_path
          click_link "#{I18n.t('.dictionary.words.priority')}"
           priorities = elements.map { |elements| elements.text }
          priorities.count.times do |n|
            expect(converter(priorities[n])).to be >= priority_orderd[n]
          end
        end
      end
    end
    describe '詳細表示機能' do
      let(:user) { build(:user_1, :use_task_6) }
      let(:link_details) { first('#sequence .details') }
       context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
           login_as_user_with_association(user)
           visit tasks_path
           link_details.click
           expect(page).to have_content('タスク234')
           expect(page).to have_content('テスト_詳細')
           expect(page).to have_content('2022/12/18')
         end
       end
    end
  end
end
