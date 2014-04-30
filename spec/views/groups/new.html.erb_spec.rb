require 'spec_helper'

describe "groups/new" do
  before(:each) do
    assign(:group, stub_model(Group,
      :user_id => 1,
      :object => "MyString",
      :obj_id => 1,
      :mode => "MyString"
    ).as_new_record)
  end

  it "renders new group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", groups_path, "post" do
      assert_select "input#group_user_id[name=?]", "group[user_id]"
      assert_select "input#group_object[name=?]", "group[object]"
      assert_select "input#group_obj_id[name=?]", "group[obj_id]"
      assert_select "input#group_mode[name=?]", "group[mode]"
    end
  end
end
