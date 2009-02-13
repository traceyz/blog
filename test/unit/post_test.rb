require 'test_helper'

class PostTest < ActiveSupport::TestCase

  should_have_many :comments
  should_require_attributes :title, :body
  
  context "a published post" do
    setup do
      @post = Factory.build(:post, :published => true)
    end
    #only uses the created post for this require
    should_require_attributes :body
  end

end
