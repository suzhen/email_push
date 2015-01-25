require 'rails_helper'

RSpec.describe "matrices/show", :type => :view do
  before(:each) do
    @matrix = assign(:matrix, Matrix.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
