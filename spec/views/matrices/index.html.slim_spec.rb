require 'rails_helper'

RSpec.describe "matrices/index", :type => :view do
  before(:each) do
    assign(:matrices, [
      Matrix.create!(),
      Matrix.create!()
    ])
  end

  it "renders a list of matrices" do
    render
  end
end
