require 'chats_publisher'
class ChatsController < ApplicationController

  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats
  def index
    @chats = Chat.fetch_cache(params.require(:application_id))

    render json: @chats
  end

  # GET /chats/1
  def show
    render json: @chat, include: 'messages'
  end

  # POST /chats
  def create
    @chat_params = chat_params
    @chat_params['application_id'] = params.require(:application_id)
    ChatsPublisher.publish(@chat_params.to_json)
  end

  # PATCH/PUT /chats/1
  def update
    @chat_params = chat_params
    @chat_params['id'] = @chat.id
    ChatsPublisher.publish(@chat_params.to_json)
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      params.require(:chat).permit(:name)
    end
end
