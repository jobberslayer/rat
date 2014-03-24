require 'spec_helper'
  
describe "Security" do
  let(:check_urls) { [
    { url: categories_url, obj: Category.new, ability: :read},
    { url: new_category_url, obj: Category.new, ability: :create},
    { url: tasks_url, obj: Task.new, ability: :read },
    { url: new_task_url, obj: Task.new, ability: :create },
    { url: companies_url, obj: Company.new, ability: :read },
    { url: admin_show_users_url, obj: Company.new, ability: :read }
  ]}

  describe "should redirect to signin page for categories." do
    it do 
      check_urls.each do |i|
        visit i[:url]
        page.should redirect_to_signin, "Problem Page #{i[:url]}" 
      end
    end 
  end

  describe "admin loading pages" do
    let(:user) { FactoryGirl.create(:admin_user) }
    before { sign_in user }  

    it do 
      check_urls.each do |i|
        visit i[:url]
        page.should_not redirect_to_signin, "Problem Page #{i[:url]}" 
        page.should_not access_denied_page, "Problem Page #{i[:url]}" 
      end
    end 
  end

  describe "normal_user loading pages" do
    let(:user) { FactoryGirl.create(:normal_user) }
    let(:ability) { Ability.new(user)}
    before { sign_in user }  

    it do 
      check_urls.each do |i|
        visit i[:url]
        page.should_not redirect_to_signin, "Problem Page #{i[:url]}"
        if ability.can? i[:ability], i[:obj]
          page.should_not access_denied_page, "Problem Page #{i[:url]}"
        else
          page.should access_denied_page, "Problem Page #{i[:url]}"
        end
      end
    end 
  end
end
