class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :not_admin, only: [:new, :create]

  def index
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def not_admin
    redirect_to root_path unless current_user.admin?
  end

  def article_params
    params.require(:article).permit(:image, :title, :content).merge(user_id: current_user.id)
  end
end
