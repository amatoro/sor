class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question_id, only: [:create, :destroy]

  private

  def vote_params 
    params.permit(:user).merge(user: current_user)
  end

  def set_question_id
    @question = Question.find(params[:question_id])
  end

end
