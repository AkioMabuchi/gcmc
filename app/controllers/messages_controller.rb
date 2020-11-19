class MessagesController < ApplicationController
  protect_from_forgery except: [
      :send_message,
      :fetch_messages
  ]

  def index

  end

  def show
    to_user = User.find_by(permalink: params[:permalink])

    raise ActiveRecord::RecordNotFound unless to_user
    @react_info = {
        permalink: params[:permalink],
        fromUserId: session[:user_id],
        toUserId: to_user.id,
        toUserName: to_user.name,
        toUserImage: to_user.image.url
    }
  end

  def send_message
    message = Message.new(
        from_user_id: params[:from_user_id],
        to_user_id: params[:to_user_id],
        content: params[:content]
    )

    if message.save
      render plain: "accepted"
    else
      render plain: "error"
    end
  end

  def fetch_messages
    from_user_id = params[:from_user_id]
    to_user_id = params[:to_user_id]

    plain_messages = Message.where(from_user_id: from_user_id, to_user_id: to_user_id).or(Message.where(from_user_id: to_user_id, to_user_id: from_user_id)).order(updated_at: :desc)

    messages = []

    plain_messages.each do |plain_message|
      message = {
          image: plain_message.from_user.image.url,
          name: plain_message.from_user.name,
          date: plain_message.updated_at.strftime("%Y-%m-%d %H:%M"),
          content: plain_message.content
      }

      messages.append message
    end

    render json: messages
  end
end
