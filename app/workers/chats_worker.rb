#!/usr/bin/env ruby
require 'bunny'
require 'active_record'
require 'sequenced'
require 'dotenv/load'

Dotenv.load

ActiveRecord::Base.establish_connection(
    :adapter  => 'mysql2',
    :database => 'ChatSys_development',
    :username => 'root',
    :password => 'root',
    :host     => ENV['MYSQL_HOSTNAME'])

require 'json'
require_relative '../models/application_record'
require_relative '../models/chat'

connection = Bunny.new(hostname: ENV['RABBITMQ_HOSTNAME'])
connection.start

channel = connection.create_channel
queue = channel.queue('chats', durable: true)

channel.prefetch(1)
puts ' [*] Waiting for messages. To exit press CTRL+C'

begin
  queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body|
    puts " [x] Received '#{body}'"
    parsed_body = JSON.parse(body)
    if  parsed_body['id'].nil?
      chat = Chat.new
      chat.from_json(body)
    else
      chat = Chat.find(parsed_body['id'])
      chat.from_json(body)
    end
    if chat.save
      puts "Saved"
    else
      puts "Failed to save"
    end
    puts ' [x] Done'
    channel.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  connection.close
end