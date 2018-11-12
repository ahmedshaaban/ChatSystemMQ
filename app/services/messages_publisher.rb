require "bunny"

class MessagesPublisher
    def self.publish(message = {})
      queue = channel.queue('messages', durable: true)
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