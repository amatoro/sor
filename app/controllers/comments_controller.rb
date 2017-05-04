class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  private

  def comment_params 
    params.require(:comment).permit(:content).merge(user: current_user)
  end
end
