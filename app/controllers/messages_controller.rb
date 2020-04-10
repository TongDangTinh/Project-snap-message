class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Recipient.where(user_id:  current_user.id).order("created_at DESC")
  end

  def new 
    @message = Message.new
    @recipients = Recipient.all
  end

  def create
    @message = current_user.messages.build message_params
    if @message.save 
      flash[:success] = "Message sent"
      redirect_to root_path
    else 
      flash[:alert] = "Great scott"
      render :new 
    end
  end

  private 
    def message_params
      params.require(:message).permit(:body :send_id, user_tokens: [])
end
