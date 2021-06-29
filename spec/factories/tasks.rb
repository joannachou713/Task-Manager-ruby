FactoryBot.define do
  factory :task do
    id {1}
    title {"title"}
    content {'string'}
    start {DateTime.now}
    endtime {(DateTime.now + 1.week)}
    priority {0}
    status {0}
    user {}
  end
end