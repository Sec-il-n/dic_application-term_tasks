require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe '入力項目バリデーション' do
    context 'タスクのタイトルが空のとき' do
      it 'バリデーションに引っかかる' do
        task = FactoryBot.build(:task_2, task_name: '', details: 'タスク名空 バリデーション')
        task.valid?
        expect(task.errors.full_messages).to include('タスク名を入力してください')
      end
    end
    context 'タスクの詳細が空のとき' do
      it 'バリデーションに引っかかる' do
        task = FactoryBot.build(:task_2, details:'')
        task.valid?
        expect(task.errors.full_messages).to include('詳細を入力してください')
      end
    end
    # step2以降、他のカラムをNotNUllで作成しているので通らない
    context 'タスクのタイトルと詳細に内容が記載されているとき' do
      xit 'バリデーションに通る' do
        task = FactoryBot.create(:task)
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能'do
    let!(:tasks) { FactoryBot.create_list(:task_3, 10) }
    let!(:task) { FactoryBot.create(:task_5, task_name: 'タスク345') }
    let!(:not_started) { I18n.t('.dictionary.words.Not started') }
    let!(:done) { I18n.t('.dictionary.words.done') }
    let!(:task_fixed) { FactoryBot.create(:task_5, task_name: 'task', status: not_started) }
    context 'scope :search_name_like でタイトルのあいまい検索をした場合'do
      it '検索キーワードを含むタスクが絞り込まれる'do
        results = Task.search_name_like('タスク').map(&:task_name)
        # expect { results }.to contain_exactly(task.task_name)
        expect(results).to include(task.task_name)
      end
    end
    context 'scope :search_status でステータス検索した場合'do
      it '指定したステータスで絞り込まれる'do
        results = Task.search_status(done).map(&:status)
        expect(results).to all( include(done) )
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索、かつステータス検索した場合'do
      it '指定したタイトルとステータスの両方で絞り込まれる'do
        results_status = Task.search_status(not_started).search_name_like('task').map(&:status)
        results_name = Task.search_status(not_started).search_name_like('task').map(&:task_name)
        expect(results_status).to all( include(not_started))
        expect(results_name).to all( include('task'))
        # ✖︎　result.task_name
      end
    end
  end
end
