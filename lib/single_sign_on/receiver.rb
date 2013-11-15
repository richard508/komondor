module SingleSignOn
  class Receiver
    def initialize signed_message
      if signed_message.nil?
        @signature = :invalid_signature
        @message = "invalid_message"
      else
        @message, @signature = signed_message.split('--')
      end
    end

    def parsed_message
      @msg ||= Marshal.load(Base64.urlsafe_decode64(@message))
    end

    def valid?
      return false unless @signature == signature
      current_time = Time.now.utc
      time_minus_3 = current_time - 3.minutes
      message_time = if parsed_message.is_a? Array
        parsed_message[1]
      else
        parsed_message[:time]
      end
      (time_minus_3..current_time).cover?(message_time)
    end

    private

    def signature
      OpenSSL::HMAC.hexdigest("sha1", ENV['SSO_SECRET_KEY'], @message)
    end
  end
end
