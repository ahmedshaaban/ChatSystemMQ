require "bunny"

class ChatsPublisher
    def self.publish(message = {})
      queue = channel.queue('chats', durable: true)
      queue.publish(message)
    end
  
    def self.channel
      @channel ||= connection.create_channel
    end
  
    def self.connection
      @connection ||= Bunny.new(hostname: ENV['RABBITMQ_HOSTNAME']).tap do |c|
        c.start
      end
    end
end