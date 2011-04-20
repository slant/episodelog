require 'spec_helper'

describe "episodes/edit.html.erb" do
  before(:each) do
    @episode = assign(:episode, stub_model(Episode))
  end

  it "renders the edit episode form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => episodes_path(@episode), :method => "post" do
    end
  end
end
