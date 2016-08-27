class CommentsController < ApplicationController
  # Only site admins can delete comments
  http_basic_authenticate_with name: "djch", password: "secret", only: :destroy

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
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: unprocessable_entity }
      end
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
