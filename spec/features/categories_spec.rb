require 'spec_helper'

describe "Categories" do
  describe "should redirect to signin page." do
    before {visit categories_url}
    it { page.should redirect_to_signin }
  end
end

describe "Categories" do
  describe "admin" do
    let(:user) { FactoryGirl.create(:admin_user) }
    before { sign_in user }  
    
    it "loading page" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit categories_url
      page.find('div#main-content > h1').text.should eq 'Listing categories'
    end
  end

  describe "normal user" do
    let(:user) { FactoryGirl.create(:normal_user) }
    before { sign_in user }  
    
    it "loading page" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit categories_url
      page.find('div.panel').text.should eq 'access denied'
    end
  end
end
