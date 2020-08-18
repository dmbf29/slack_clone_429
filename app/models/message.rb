class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
  after_create :broadcast

  def broadcast
    ChatroomChannel.broadcast_to(
      self.chatroom,
      render_to_string(partial: "message", locals: { message: self })
    )
  end
end
