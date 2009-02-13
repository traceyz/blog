require 'test_helper'

class Admin::PostsControllerTest < ActionController::TestCase
  should_route :get, "/admin/posts/new", {:controller => "admin/posts", :action => :new}
  
  context "on GET to new" do
    setup do
      get :new
    end

    should_respond_with :success
    should_render_template :new
    should_assign_to :post

    should "render navigation with a link to index" do
      assert_select 'div.navigation' do
        assert_select 'a[href=?]', posts_path
        assert_select 'a[href=?]', new_admin_post_path, :count => 0
      end
    end

    should "show a form to create a new post" do
      assert_select 'form[action=?][method=post]', admin_posts_path do
        assert_select 'input[type=text][name=?]', 'post[title]'
        assert_select 'input[type=text][name=?]', 'post[author]'
        assert_select 'textarea[name=?]', 'post[body]'
        assert_select 'input[type=checkbox][name=?]', 'post[published]'
        assert_select 'input[type=submit]'
      end
    end
  end
  
  
  context "on POST to create with valid post parameters" do
    setup do
      @post_count = Post.count
      post :create, :post => { :title => 'Test Title',  :body => 'Test Body' }
    end

    should_redirect_to "posts_path"
    should_set_the_flash_to /created/

    should "create a new post record" do
      assert_equal @post_count + 1, Post.count
    end

    should "create a post with the given title" do
      assert_not_nil post = Post.last
      assert_equal   'Test Title', post.title
    end
  end

  context "on POST to create with invalid post parameters" do
    setup do
      post :create, :post => {}
    end

    should_respond_with :success
    should_render_template :new
    should_not_set_the_flash

    should "display error messages" do
      assert_select '#errorExplanation'
    end
  end
  
end
