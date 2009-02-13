class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    if @comment.save
      flash[:success] = 'Your comment has been added.'
      redirect_to post_path(@post)
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment Deleted"
    redirect_to posts_path
    
  end

end
