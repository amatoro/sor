class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question_id = params[:question_id]

    if @answer.save
      flash[:notice] = "The answer has been saved"
    else
      if @answer.errors.any?
        @answer.errors.full_messages.each do |message| 
          flash[:alert] = "There was a failure, the answer couldn't been saved. Reason: " + message
        end
      end
    end
    redirect_to @answer.question
  end

  def edit
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)

    if @answer.user == current_user
      @answer = Answer.find(params[:id])
    else
      flash[:alert] = "You're not allowed to edit this answer"
      redirect_to question_path
    end
  end

  def update
    @answer = Answer.find(params[:id])

    if @answer.update(answer_params)
      flash[:notice] = "The answer has been updated"
      redirect_to @answer.question
    else
      flash[:alert] = "There was a failure, the answer couldn't been saved"
      render :edit
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    
    if @answer.user == current_user
      @answer.destroy
      flash[:alert] = "The answer has been deleted"
    else
      flash[:alert] = "You're not allowed to delete this entry"
    end
    redirect_to @answer.question
  end

  private

  def answer_params 
    params.require(:answer).permit(:content)
  end
end
