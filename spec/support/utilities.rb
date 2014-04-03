RSpec::Matchers.define :redirect_to_signin do
  match do |page|
    current_path.should eq new_user_session_path
    page.should have_notice_message "You need to sign in or sign up before continuing."
  end 

  failure_message_for_should do |obj|
    "should redirect to sign in screen, not #{current_path}"
  end 

  failure_message_for_should_not do |obj|
    "should not redirect to sign in screen"
  end 
end

RSpec::Matchers.define :have_notice_message do |message|
  match do |page|
    page.should have_selector('div.alert-box', text: message)
  end
  failure_message_for_should do |obj|
    alert_fail_message(obj, message, 'notice', false)
  end

  failure_message_for_should_not do |obj|
    alert_fail_message(obj, message, 'notice', true)
  end
end

RSpec::Matchers.define :access_denied_page do
  match do |page|
    #cs = page.find('div.panel')
    cs = page.find('div#main-content')
    if cs.text.nil?
      return false
    else
      cs.text.should eq 'access denied'
    end
  end
end

RSpec::Matchers.define :page_loaded do |page_url, h1_text|
  match do |page|
    page.find('div.panel > h1').text.should eq h1_text 
  end
end

def sign_in(user)
  visit new_user_session_url
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button 'Sign in'
end


