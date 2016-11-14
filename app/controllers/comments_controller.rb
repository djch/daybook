class CommentsController < ApplicationController
  before_action :set_article

  def create
    @comment = @article.comments.new(comment_params)

    # Handle XHR comment submissions
    respond_to do |format|
      if @comment.save
        format.html { redirect_to article_path(@comment) }
        format.js
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    # The 'destroy' JS partial removes it from the client-side
    @comment.destroy
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
