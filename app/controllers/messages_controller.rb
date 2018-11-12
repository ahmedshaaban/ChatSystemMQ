require 'messages_publisher'
class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    @messages = Message.all

    render json: @messages
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    @message_params = message_params
    @message_params['chat_id'] = params.require(:chat_id)
    MessagesPublisher.publish(@message_params.to_json)
  end

  # PATCH/PUT /messages/1
  def update
    @message_params = message_params
    @message_params['id'] = @message.id
    MessagesPublisher.publish(@message_params.to_json)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:body)
    end
end
