require 'spec_helper'

describe "episodes/show.html.erb" do
  before(:each) do
    @episode = assign(:episode, stub_model(Episode))
  end

  it "renders attributes in <p>" do
    render
  end
end
