require 'spec_helper'

describe User do
  let(:normal_user) { FactoryGirl.create(:normal_user)}
  let(:admin_user) { FactoryGirl.create(:admin_user)}

  it { normal_user.admin?.should == false}
  it { admin_user.admin?.should == true}
end
