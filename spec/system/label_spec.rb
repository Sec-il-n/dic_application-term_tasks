require 'rails_helper'
describe 'ラベル管理機能'do
  let(:confirmation) { find(:xpath, '/html/body/div/div/div/form/div[3]/input[2]') }
  let(:user) { create(:user) }
  let(:user_2) { create(:user_2) }
  let(:label_first) { first('.labels label') }
  context 'タスクの新規作成時'do
    it 'そのタスクに紐づいたラベルを選択し登録できる'do
      login_as_user_with_association(user)
      visit new_task_path
      # 終了期限のvalidationsの問題があるので切り出してさらに流動的な値を代入できるようにする。
      fill_in 'タスク名', with: 'task_name'
      fill_in '詳細', with: 'task_details'
      fill_in '終了期限', with: '002022-12-18'
      find('#task_status').find(:xpath, 'option[3]').select_option
      # checkboxのチェックはラベルで行う(インプットだと「""」で認識できない)
      label = label_first.text
      # 流動的な要素はfirst以外↓✖︎（？）　←後から記載
      # label = find('/html/body/div/div/div/form/div[7]/input[1]').text
      check(label)
      click_on('登録する')
      expect(page).to have_content("#{I18n.t('.tasks.index.task created')}")
    end
  end
  context 'タスクを編集する際'do
    let(:labels) { all('.labels label') }
    it 'そのタスクに紐づいたラベルを選択し再登録(更新)できる'do
      login_as_user_with_association(user)
      visit tasks_path

      first('#sequence .link_edit').click
      labels.each { |label| check(label.text) }
      click_on '更新する'
      expect(page).to have_content("#{I18n.t('.tasks.index.task edited')}")
    end
  end
  context 'タスク新規登録時または編集時'do
    it '管理者の管理するラベル(seed)とログインユーザーが作成したラベルのみ選択できる'do
    login_as_user_with_association(user)
    visit new_label_path
    fill_in "#{I18n.t('.labels.show.label name')}", with: '自作ラベル'
    find(:xpath,'/html/body/div/div/div/form/div[2]/input[2]').click
    find(:xpath,'/html/body/div/div/div/form/div[3]/input[2]').click
    visit new_task_path
    expect(page).to have_field('自作ラベル')
    # expect(page).to have_content('自作ラベル')
    end
  end
  it 'ログインユーザがラベルを作成ができる' do
    login_as_user
    #  undefined local variable or method ？！ tasks_spec_helpper。rbに移しても同じ
    # create_own_label　
    visit new_label_path
    fill_in "#{I18n.t('.labels.show.label name')}", with: '自作ラベル'
    find(:xpath,'/html/body/div/div/div/form/div[2]/input[2]').click

    confirmation.click
    expect(page).to have_content("#{I18n.t('.labels.create.label created')}")
  end
  it'タスクに複数のラベルをつけられる' do
    login_as_user_with_association(user)
    # fill_in_form helpers使えない問題　'タスクを新規作成'でも使いたい<=確認別appを編集していた可能性あり
    # 切り出し
    visit new_task_path
    fill_in 'タスク名', with: 'task_name'
    fill_in '詳細', with: 'task_details'
    fill_in '終了期限', with: '002022-12-18'
    find('#task_status').find(:xpath, 'option[3]').select_option

    check('label_4')
    check('label_5')
    check('label_6')
    click_on('登録する')
    expect(page).to have_content('label_4')
    expect(page).to have_content('label_5')
    expect(page).to have_content('label_6')
  end
  context 'タスクの詳細画面に遷移した場合'do
    # let(:elements) { all(:xpath, '//*[@id="link_show"]') }
    # let(:user) { create (:user) }
    let(:task) { create (:task_7) }
    let(:label) { create (:label) }
    it'タスクに紐づいているラベル一覧が出力される'do
      login_as_user_with_association(user)
      visit tasks_path
      first('.link_shown').click
      #userがloginで呼び出されるごとに生成され、個数は定義通りだが
      # sequenceが連番
      expect(page).to have_content('label_16')
      # expect(page).to have_content('label_13')
      # expect(page).to have_content('label_10')
      # expect(page).to have_content('label_7')
      # expect(page).to have_content('label_1')
    end
  end
  describe 'ラベル検索機能'do
    context 'ラベルを一つ選択した場合'do
      it 'そのラベルがついているタスクが表示される'do
        login_as_user_with_association(user)
        visit tasks_path
        names = user.labels.map {|l| l.label_name}
        # ドロップダウンジャないcheck box
        # names.each { |name| select name , from: 'ラベル' }
        find('#label_id').find(:xpath, 'option[1]').select_option
        # find(names[0]).select_option#無理
        click_on('検索')
        first('.link_shown').click
        expect(find('#labels').text).to eq names[0]

        # contoroller
        # names.each do |name|
        #   # elm_text = find('#label_id').find(:xpath, 'option[1]').text
        #   find('#label_id').find(:xpath, 'option[1]').select_option
        #   click_on('検索')
        #   binding.pry
        #   # user。tasks.each do |task| task.managers.label_id ==
        #   #label_13~15
        # end
      end
    end
  end
end
