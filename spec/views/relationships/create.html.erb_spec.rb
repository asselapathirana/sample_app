require 'spec_helper'

describe "/relationships/create" do
  before(:each) do
    render 'relationships/create'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/relationships/create])
  end
end
