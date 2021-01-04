class MessagesController < ApplicationController
  protect_from_forgery except: [
      :create
  ]

  def index

  end

  def show
    from_user = @current_user
    to_user = User.find_by(permalink: params[:permalink])

    raise Forbidden unless from_user
    raise ActiveRecord::RecordNotFound unless to_user

    plain_messages = Message.where(from_user_id: from_user.id, to_user_id: to_user.id).or(Message.where(from_user_id: to_user.id, to_user_id: from_user.id)).order(updated_at: :desc)

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

    @react_info = {
        permalink: params[:permalink],
        fromUserId: session[:user_id],
        toUserId: to_user.id,
        toUserName: to_user.name,
        toUserImage: to_user.image.url,
        messages: messages
    }
  end

  def create
    to_user = User.find_by(permalink: params[:permalink])
    message = Message.new(
        from_user_id: session[:user_id],
        to_user_id: to_user.id,
        content: params[:content]
    )

    message.save!

    message_output = {
        fromUserId: message.from_user_id,
        toUserId: message.to_user_id,
        image: message.from_user.image.url,
        name: message.from_user.name,
        date: message.updated_at.strftime("%Y-%m-%d %H:%M"),
        content: message.content
    }

    ActionCable.server.broadcast "message_channel", message: message_output.as_json
  end
end
