class Questions::VotesController < VotesController 

  def create
    @vote = @question.votes.new(vote_params)
    

    if @vote.save
      flash[:notice] = "Thanks for contributing!"
    else
      if @vote.errors.any?
        @vote.errors.full_messages.each do |message| 
          flash[:alert] = message
        end
      end
    end
    redirect_to question_path(@question)
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.user = current_user

    if @vote.user == current_user
      @vote.destroy
      flash[:alert] = "The vote has been removed"
    else
      flash[:alert] = "You haven't voted yet!"
    end
    redirect_to question_path(@question)
  end
  
end