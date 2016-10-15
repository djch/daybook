class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)

    # Handle AJAX comment submissions
    respond_to do |format|
      if @comment.save
        format.html { redirect_to article_path(@comment), notice: "Comment added!" }
        format.js   {}
        format.json {render json: @comment,
                            status: :created,
                            location: article_path(@comment) }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: unprocessable_entity }
      end
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
