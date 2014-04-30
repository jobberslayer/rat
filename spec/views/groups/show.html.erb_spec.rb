require 'spec_helper'

describe "groups/show" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :user_id => 1,
      :object => "Object",
      :obj_id => 2,
      :mode => "Mode"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Object/)
    rendered.should match(/2/)
    rendered.should match(/Mode/)
  end
end
