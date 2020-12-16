class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  def index
    @blogs = Blog.all
  end
  def new
    @blog = current_user.blogs.build
  end
  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        redirect_to new_blog_path, notice: "作成しました。"
      else
        render :new
      end
    end
  end
  def show
  end
  def edit
  end
  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end
  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end


  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end
  def set_blog
    @blog = Blog.find(params[:id])
  end
end
