FactoryGirl.define do
  factory :task do
    title "Parent Task"
    info "This is the parent task"
    # provide when creating
    # user_id
    # company_id
  end
end
