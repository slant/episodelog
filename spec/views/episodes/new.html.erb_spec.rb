require 'spec_helper'

describe "episodes/new.html.erb" do
  before(:each) do
    assign(:episode, stub_model(Episode).as_new_record)
  end

  it "renders new episode form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => episodes_path, :method => "post" do
    end
  end
end
