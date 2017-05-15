class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question_id, only: [:edit, :update, :create, :destroy]
  
  private

  def comment_params 
    params.require(:comment).permit(:content).merge(user: current_user)
  end

  def set_question_id
    @question = Question.find(params[:question_id])
  end
  
  def set_answer_id
    @answer = Answer.find(params[:answer_id])
  end
end
