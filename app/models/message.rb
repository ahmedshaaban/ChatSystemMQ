class Message < ApplicationRecord
  belongs_to :chat

  acts_as_sequenced scope: :chat_id
end
