require 'rails_helper'
require 'active_support/time'
require 'date'
RSpec.describe Task, type: :system do
  describe 'タスク管理機能' do
    context 'タスクを新規作成したとき' do
      xit '作成したタスクが画面に表示される' do
        #追記
        login_as_user
        visit new_task_path
        # visit current_path
        fill_in 'タスク名', with: 'task_name'
        fill_in '詳細', with: 'task_details'
        fill_in '終了期限', with: '002022-12-18'#ずれ込まないよう'00'でうめる
        # step3で修正
        find('#task_status').find(:xpath, 'option[3]').select_option
        binding.pry
        click_button '登録する'
        expect(page).to have_content('task_name')
        expect(page).to have_content('task_details')
        expect(page).to have_content('2022/12/18')
        expect(page).to have_content('着手中')
      end
    end
    describe '一覧表示機能' do
     context '一覧画面に遷移した場合' do
        xit '作成済みのタスク一覧が表示される' do
          task = FactoryBot.create(:task_5)
          login_as_user
          visit tasks_path
          expect(page).to have_content('タスク')
          expect(page).to have_content('テスト_詳細')
          expect(page).to have_content('2022/12/18')
          # expect(page).to have_content("#{Time.current.since(10.days)}")
        end
      end
      context '一覧画面表示されたとき' do
        xit '作成日時の降順で表示される' do
          task = FactoryBot.create_list(:task_3, 10)
          login_as_user
          visit tasks_path
          task_list = all('#sequence #task_name')
          # binding.pry
          j = 9
          for i in 0..9
            expect(task_list[i].text).to have_content(task[j].task_name)
            j -= 1
          end
        end
      end
    end
    describe '検索機能' do
      context 'タイトルで曖昧検索した場合' do
        xit 'タイトルを含むタスクの一覧が表示される' do
          login_as_user
          visit tasks_path
          fill_in :task_name, with: 'タスク'#reated at test_5
          # fill_in 'task_name', with: 'タスク'#reated at test_5
          click_button I18n.t('.dictionary.words.search')
          expect(page).to have_content('タスク')
        end
      end

      context 'ステータスで検索した場合' do
        xit '指定したステータスのタスク一覧が表示される' do
          FactoryBot.create_list(:task_5, 20)
          login_as_user
          visit tasks_path
          #プルダウンでオプション２「着手中」を選択
          find('#status').find(:xpath, 'option[3]').select_option
          click_button "#{I18n.t('.dictionary.words.search')}"
          elements = all(:xpath, '//*[@id="status_shown"]')
          # elements = all(:xpath, '/html/body/table/tbody/tr/td[5]')
          # //*[@id="status_shown"]
          # binding.pry
          elements.count.times do |n|
            expect(elements[n].text).to eq "#{I18n.t('.dictionary.words.Already started')}"
            # expect(elements[n].text).to have_content("#{I18n.t('.dictionary.words.Already started')}")
          end
        end
      end

      context 'タイトルとステータスで検索した場合' do
        xit 'タイトルを含み指定したステータスのタスクの一覧が表示される' do
          FactoryBot.create_list(:task_3, 10)
          task = FactoryBot.create(:task_6)
          login_as_user
          visit tasks_path
          # タスク234 未着手
          fill_in :task_name, with: 'タスク234'
          find('#status').find(:xpath, 'option[1]').select_option
          click_button("#{I18n.t('.dictionary.words.search')}")

          expect(find('#sequence #task_name')).to have_content(task.task_name)
          expect(find('#sequence #status_shown')).to have_content(task.status)
        end
      end
    end
    describe '並べ替え機能'do
      context '終了期限のリンクをクリックした場合'do
        let(:elements) { all(:xpath, '//*[@id="valid_shown"]') }
        let(:valid_orderd) { Task.order_valid.map { |t| t.valid_date } }
        xit '終了期限の昇順に表示される'do
          tasks = FactoryBot.create_list(:task_3, 20)
          login_as_user
          visit  tasks_path
          click_link "#{I18n.t('.dictionary.words.valid_date')}"
          # find_link("#{I18n.t('.dictionary.words.valid_date')}").click
          elements.count.times do |n|
            # tasks = tasks.order( valid_date: :ASC )
            # NameError: undefined local variable or method `tasks_orderd'
            expect(elements[n].text).to eq valid_orderd[n].strftime('%Y/%m/%d')
          end
        end
      end
      context '優先順位のリンクをクリックした場合'do
        let(:elements) { all(:xpath, '//*[@id="priority_shown"]') }
        let(:priority_orderd) { Task.order_priority.map { |t| t.priority_before_type_cast } }
        xit '優先順位の高いものから順に表示される'do
          tasks = FactoryBot.create_list(:task_3, 20)
          login_as_user
          visit tasks_path
          click_link "#{I18n.t('.dictionary.words.priority')}"
          elements.count.times do |n|
            # binding.pry
            expect(converter(elements[n].text)).to be >= priority_orderd[n]
          end

        end
      end
    end
    describe '詳細表示機能' do
       context '任意のタスク詳細画面に遷移した場合' do
        xit '該当タスクの内容が表示される' do
           task = FactoryBot.create(:task_5, details: '詳細上書き')
           login_as_user
           visit task_path(task.id)
           expect(page).to have_content('タスク')
           expect(page).to have_content('詳細上書き')
           expect(page).to have_content('2020/12/18')
         end
       end
    end
  end
end
