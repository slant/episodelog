require 'spec_helper'

describe "shows/show.html.erb" do
  before(:each) do
    @show = assign(:show, stub_model(Show))
  end

  it "renders attributes in <p>" do
    render
  end
end
