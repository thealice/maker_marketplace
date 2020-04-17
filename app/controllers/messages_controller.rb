class MessagesController < ApplicationController
    before_action :set_conversation
  
    def index

    end
  
    def create
      @message = @conversation.messages.new(message_params)
      if @message.save
        redirect_to conversation_messages_path(@conversation)
      end
    end
  
    def new
      @message = @conversation.messages.new
    end
  
    private
  
      def message_params
        params.require(:message).permit(:body, :user_id)
      end
  
      def set_conversation
        @conversation = Conversation.find(params[:conversation_id])
      end
  end