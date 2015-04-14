FactoryGirl.define do
  factory :user do
    name "john"
    email "doe@example.com"
    password "foobar"
  end

  factory :admin, parent: :user do
    role "admin"
  end

  factory :invalid_user, parent: :user do
    email nil
  end

end
