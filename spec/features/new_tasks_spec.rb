require 'spec_helper'

describe "New Task signed out", type: :feature do
  describe "should redirect to signin page." do
    before {visit new_task_url}
    it { page.should redirect_to_signin }
  end
end

describe "New Task", type: :feature do
  let!(:user) { FactoryGirl.create(:normal_user)}
  let!(:company) { FactoryGirl.create(:company) }
  let!(:category) { FactoryGirl.create(:category) }

  before do
    sign_in user
    visit new_task_url({show_scheduler: 1})
  end

  describe "should load for normal user" do
    it do
      find('nav.breadcrumbs > li > strong').text.should eq "New Task" 
    end
  end

  describe "with no schedule" do
    it do
      page.should have_select("Company", options: [company.name])
      page.should have_select("Category", options: [category.name])
      page.should have_select("User", options: [user.full_name])

      select(company.name, from: "Company")
      select(category.name, from: "Category")
      select(user.full_name, from: "User")

      fill_in('Title', with: 'Test Title')
      fill_in('Info', with: 'This is a test')
      click_button('Create Task')

      page.should have_title("Task Detail")
      page.find("fieldset > legend").text.should eq 'Scheduled'
      page.find("fieldset > p").text.should eq 'none'

    end
  end

  describe "with once schedule" do
    it do
      page.should have_select("Company", options: [company.name])
      page.should have_select("Category", options: [category.name])
      page.should have_select("User", options: [user.full_name])

      select(company.name, from: "Company")
      select(category.name, from: "Category")
      select(user.full_name, from: "User")

      fill_in('task[title]', with: 'Test Title')
      fill_in('Info', with: 'This is a test')

      select('Once', from: "task[schedule_attributes][kind]") 
      fill_in 'task[schedule_attributes][once_date]', with: Date.today.strftime('%Y-%m-%d)')

      click_button('Create Task')

      page.should have_title("Task Detail")
      page.find("fieldset > legend").text.should eq 'Scheduled'
      page.find("fieldset > p").text.should eq Date.today.strftime('%B %d, %Y') 

    end
  end

  describe "with yearly schedule" do
    it do
      page.should have_select("Company", options: [company.name])
      page.should have_select("Category", options: [category.name])
      page.should have_select("User", options: [user.full_name])

      select(company.name, from: "Company")
      select(category.name, from: "Category")
      select(user.full_name, from: "User")

      fill_in('task[title]', with: 'Test Title')
      fill_in('Info', with: 'This is a test')

      select('Yearly', from: "task[schedule_attributes][kind]") 
      fill_in 'task[schedule_attributes][yearly_date]', with: Date.today.strftime('%Y-%m-%d)')

      click_button('Create Task')

      page.should have_title("Task Detail")
      page.find("fieldset > legend").text.should eq 'Scheduled'
      month = Date.today.strftime("%B")
      day = Date.today.day.ordinalize
      page.find("fieldset > p").text.should eq Date.today.strftime("Yearly in #{month} on the #{day} day of the month") 
    end
  end

  describe "with monthly schedule" do
    it do
      page.should have_select("Company", options: [company.name])
      page.should have_select("Category", options: [category.name])
      page.should have_select("User", options: [user.full_name])

      select(company.name, from: "Company")
      select(category.name, from: "Category")
      select(user.full_name, from: "User")

      fill_in('task[title]', with: 'Test Title')
      fill_in('Info', with: 'This is a test')

      select('Monthly', from: "task[schedule_attributes][kind]") 
      select("15", from: 'task[schedule_attributes][monthly_day]')

      click_button('Create Task')

      page.should have_title("Task Detail")
      page.find("fieldset > legend").text.should eq 'Scheduled'
      page.find("fieldset > p").text.should eq Date.today.strftime("Monthly on the 15th day of the month") 
    end
  end

  describe "with every few months schedule" do
    it do
      page.should have_select("Company", options: [company.name])
      page.should have_select("Category", options: [category.name])
      page.should have_select("User", options: [user.full_name])

      select(company.name, from: "Company")
      select(category.name, from: "Category")
      select(user.full_name, from: "User")

      fill_in('task[title]', with: 'Test Title')
      fill_in('Info', with: 'This is a test')

      select('Every X Month', from: "task[schedule_attributes][kind]") 
      fill_in('task[schedule_attributes][few_months_recur]', with: '2')
      select(15, from: "task[schedule_attributes][few_months_day]")

      click_button('Create Task')

      page.should have_title("Task Detail")
      page.find("fieldset > legend").text.should eq 'Scheduled'
      page.find("fieldset > p").text.should eq Date.today.strftime("Every 2 months on the 15th day of the month") 
    end
  end

  describe "with weekly schedule" do
    it do
      page.should have_select("Company", options: [company.name])
      page.should have_select("Category", options: [category.name])
      page.should have_select("User", options: [user.full_name])

      select(company.name, from: "Company")
      select(category.name, from: "Category")
      select(user.full_name, from: "User")

      fill_in('task[title]', with: 'Test Title')
      fill_in('Info', with: 'This is a test')

      select('Weekly', from: "task[schedule_attributes][kind]") 
      fill_in('task[schedule_attributes][weekly_interval]', with: '4')
      fill_in("task[schedule_attributes][weekly_date]", with: '2014-02-01')

      click_button('Create Task')

      page.should have_title("Task Detail")
      page.find("fieldset > legend").text.should eq 'Scheduled'
      page.find("fieldset > p").text.should eq Date.today.strftime("Every 4 weeks starting on Saturday, February 01, 2014") 
    end
  end

  describe "with start of month schedule" do
    it do
      page.should have_select("Company", options: [company.name])
      page.should have_select("Category", options: [category.name])
      page.should have_select("User", options: [user.full_name])

      select(company.name, from: "Company")
      select(category.name, from: "Category")
      select(user.full_name, from: "User")

      fill_in('task[title]', with: 'Test Title')
      fill_in('Info', with: 'This is a test')

      select('Start of Month', from: "task[schedule_attributes][kind]") 

      click_button('Create Task')

      page.should have_title("Task Detail")
      page.find("fieldset > legend").text.should eq 'Scheduled'
      page.find("fieldset > p").text.should eq Date.today.strftime("Monthly on the 1st day of the month") 
    end
  end

  describe "with last of month schedule" do
    it do
      page.should have_select("Company", options: [company.name])
      page.should have_select("Category", options: [category.name])
      page.should have_select("User", options: [user.full_name])

      select(company.name, from: "Company")
      select(category.name, from: "Category")
      select(user.full_name, from: "User")

      fill_in('task[title]', with: 'Test Title')
      fill_in('Info', with: 'This is a test')

      select('Last of Month', from: "task[schedule_attributes][kind]") 

      click_button('Create Task')

      page.should have_title("Task Detail")
      page.find("fieldset > legend").text.should eq 'Scheduled'
      page.find("fieldset > p").text.should eq Date.today.strftime("Monthly on the last day of the month") 
    end
  end
end
