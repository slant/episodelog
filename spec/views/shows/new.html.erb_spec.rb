require 'spec_helper'

describe "shows/new.html.erb" do
  before(:each) do
    assign(:show, stub_model(Show).as_new_record)
  end

  it "renders new show form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => shows_path, :method => "post" do
    end
  end
end
