require 'rails_helper'

RSpec.describe "matrices/new", :type => :view do
  before(:each) do
    assign(:matrix, Matrix.new())
  end

  it "renders new matrix form" do
    render

    assert_select "form[action=?][method=?]", matrices_path, "post" do
    end
  end
end
