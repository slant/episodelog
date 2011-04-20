require 'spec_helper'

describe "shows/index.html.erb" do
  before(:each) do
    assign(:shows, [
      stub_model(Show),
      stub_model(Show)
    ])
  end

  it "renders a list of shows" do
    render
  end
end
