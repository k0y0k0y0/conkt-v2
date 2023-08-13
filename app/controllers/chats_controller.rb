class ChatsController < ApplicationController
  before_action do
    if params[:room_id].present?
      @room = Room.find(params[:room_id])
    end
  end

  def index
    @chats = @room.chats

    if @chats.length > 10
      @over_ten = true
      @chats = Chat.where(id: @chats[-10..-1].pluck(:id))
    end

    if params[:m]
      @over_ten = false
      @chats = @room.chats
    end

    if @chats.last
      @chats.where.not(user_id: current_user.id).update_all(read: true)
    end
    @chats = @chats.order(:created_at)
    @chat = @room.chats.build

  end

  def show
  end

  def create
    @chat = @room.chats.build(chat_params)
    @chats = @room.chats.order(:created_at)
    respond_to do |format|
      if @chat.save
        format.js { render :index }
      else
        format.html { redirect_to chats_path(@chat), notice: '投稿できませんでした...' }
      end
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :user_id)
  end
end
