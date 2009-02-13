class Admin::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:success] = 'Your post has been created.'
      redirect_to posts_path
    else
      render :action => 'new'
    end
  end
  
end
