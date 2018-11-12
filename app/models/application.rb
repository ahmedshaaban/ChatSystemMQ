class Application < ApplicationRecord
    has_secure_token :token
    has_many :chats

    def self.fetch_cache
        applications =  $redis.get("applications")
        if applications.nil?
          applications = Application.all
          $redis.set("applications", applications.to_json)
          $redis.expire("applications",10.seconds.to_i)
        end
        @applications = applications
    end
end
