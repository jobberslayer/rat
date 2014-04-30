require 'spec_helper'

describe "groups/index" do
  before(:each) do
    assign(:groups, [
      stub_model(Group,
        :user_id => 1,
        :object => "Object",
        :obj_id => 2,
        :mode => "Mode"
      ),
      stub_model(Group,
        :user_id => 1,
        :object => "Object",
        :obj_id => 2,
        :mode => "Mode"
      )
    ])
  end

  it "renders a list of groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Object".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Mode".to_s, :count => 2
  end
end
