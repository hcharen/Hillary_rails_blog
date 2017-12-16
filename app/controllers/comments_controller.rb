class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id

      if @comment.save
        redirect_to post_path(@post)
      else
        render root_path
      end
    end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

    def set_post
  @post = Post.find(params[:post_id])
    end
end
