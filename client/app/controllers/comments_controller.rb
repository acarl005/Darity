class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @dare = Dare.find(@comment.dare_id)
    if @comment.save
      render json: { comment: @comment, username: current_user.username }.to_json
    else
      return "fail!"
      #need error handling
    end
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.likes += 1
    @comment.save
    render json: @comment
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.likes -= 1
    @comment.save
    render json: @comment
  end


  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :dare_id)
  end

  

end
