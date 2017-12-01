class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]


  # List all posts
  def index
    @posts = Post.all
  end
  # GET request
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  # for updating articles
  def edit
    @post = Post.find(params[:id])
  end
  # will save the data to the database
  def create
      @post = current_user.posts.new(post_params)

    if @post.save # responsible for saving the model to the database
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, :avatar)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
   unless current_user == @post.user
         redirect_to root_path
       end
     end
end
