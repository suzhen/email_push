require 'rails_helper'

RSpec.describe "matrices/edit", :type => :view do
  before(:each) do
    @matrix = assign(:matrix, Matrix.create!())
  end

  it "renders the edit matrix form" do
    render

    assert_select "form[action=?][method=?]", matrix_path(@matrix), "post" do
    end
  end
end
