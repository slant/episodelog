require 'spec_helper'

describe "episodes/index.html.erb" do
  before(:each) do
    assign(:episodes, [
      stub_model(Episode),
      stub_model(Episode)
    ])
  end

  it "renders a list of episodes" do
    render
  end
end
