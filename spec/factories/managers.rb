FactoryBot.define do
  factory :manager do
    # belongs_to & foreigin_key　has_manyでは使用不可
    association :label
    association :task, factory: :task_7
    # assosiation名が違う(associationが :userでFactoryで別名を使用)場合
    # association : association名 , factory: 使用するfactory
  end
end
# ？？
# ファクトリー名（≒association名の場合　conv factory: :ファクトリー名）
# conv factory: :task_7
