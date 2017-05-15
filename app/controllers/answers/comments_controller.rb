class Answers::CommentsController < CommentsController
  before_action :set_answer_id, only: [:edit, :update, :create, :destroy]

  def edit
    @comment = @answer.comments.find(params[:id])
  end

  def update
    @comment = @answer.comments.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "The comment has been updated"
      redirect_to question_path(@question)
    else
      flash[:alert] = "There was a failure, the comment couldn't been saved"
      render :edit
    end
  end

  def create
    @comment = @answer.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "The comment has been saved"
    else
      if @comment.errors.any?
        @comment.errors.full_messages.each do |message| 
          flash[:alert] = "There was a failure, the comment couldn't been saved. Reason: " + message
        end
      end
    end
    redirect_to question_path(@question)
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.user == current_user
      @comment.destroy
      flash[:alert] = "The comment has been deleted"
    else
      flash[:alert] = "You're not allowed to be here"
      
    end
    redirect_to question_path(@question)
  end

end