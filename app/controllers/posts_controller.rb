class PostsController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :update]
  before_action :set_post, only: [:show, :edit, :update]
  before_action :authorize_user, only: [:edit, :update]

  def index
    @posts = Post.includes(:user).all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user
    redirect_to posts_path, alert: "Not authorized." unless @post.user == current_user
  end
end

