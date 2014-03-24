FactoryGirl.define do
  factory :user do 
    factory :normal_user do
      first_name "Normal"
      last_name "Guy"
      email "normal@test.com"
      password "password"
      password_confirmation "password"
    end 

    factory :admin_user do
      first_name "Admin"
      last_name "Fellow"
      email 'admin@test.com'
      password 'password'
      password_confirmation 'password'
      admin true
    end
  end
end
