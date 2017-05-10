class QuestionsController < ApplicationController
  # include ActiveModel::Dirty
  # define_attribute_methods :updated_at

  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # def last_action
  #   if @question.changed?
  #   end
  # end
  

  def index
    @questions = Question.all
  end

  def show
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
    if @question.user == current_user
      @question
    else
      flash[:alert] = "You're not allowed to be here"
      redirect_to question_path
    end
  end

  def update
    if @question.update(question_params)
      flash[:notice] = "The question has been updated"
      redirect_to question_path(@question)
    else
      flash[:alert] = "There was a failure, the question couldn't been saved"
      render :edit
    end
  end

  def destroy
    @vote = @vote_id

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

  def set_question
    @question = Question.find(params[:id])
  end

end
