class CommentsController < ApplicationController
  before_action :set_article, only: [:new, :edit, :update]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      ActionCable.server.broadcast 'comment_channel', content: comment, name: comment.user.name
    end
  end

  def edit
  end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, article_id: params[:article_id])
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
