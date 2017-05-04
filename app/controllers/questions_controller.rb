class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    

    if @question.save
      flash[:notice] = "The question has been saved"
      redirect_to question_path(@question)
    else
      if @question.errors.any?
        @question.errors.full_messages.each do |message| 
          flash[:alert] = "There was a failure, the question couldn't been saved. Reason: " + message
        end
      end
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])

    if @question.user == current_user
      @question = Question.find(params[:id])
    else
      flash[:alert] = "You're not allowed to be here"
      redirect_to question_path
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = "The question has been updated"
      redirect_to question_path(@question)
    else
      flash[:alert] = "There was a failure, the question couldn't been saved"
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])

    if @question.user == current_user
      @question.destroy
      flash[:alert] = "The question has been deleted"
      redirect_to questions_path
    else
      flash[:alert] = "You're not allowed to be here"
      redirect_to questions_path
    end
  end

  private

  def question_params 
    params.require(:question).permit(:title, :content)
  end
end
