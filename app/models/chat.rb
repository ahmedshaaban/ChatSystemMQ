class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages
  acts_as_sequenced scope: :application_id

  def self.fetch_cache(application_id)
    chats =  $redis.get("chats" + application_id)
    if chats.nil?
      chats = Chat.where(application_id: application_id)
      $redis.set("chats" + application_id, chats.to_json)
      $redis.expire("chats" + application_id, 10.seconds.to_i)
    end
    @chats = chats
  end
end
