require 'net/https'
require 'uri'
require 'json'

module Tasks
  class AcMorningAutoOff
    class << self
      def apipost
        date = Time.zone.now
        if date.wday >= 1 && date.wday <= 5
          row_uri = ENV['BEEBOTTE_URI']
          uri = URI.parse(row_uri)
          https = Net::HTTP.new(uri.host, uri.port)
          https.use_ssl = true
          req = Net::HTTP::Post.new(row_uri)
          req['Content-Type'] = 'application/json'
          payload = { 'data' => 'AC_OFF' }.to_json
          req.body = payload
          res = https.start { |http| http.request(req) }
          puts res.body
        end
      end
    end
  end
end
