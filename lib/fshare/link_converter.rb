module Fshare
  class LinkConverter
    def self.convert(url)
      new(url).convert
    end

    def initialize(url = '')
      @url = url
    end

    def convert
      parse(converted_link)['url']
    end

    private

    def parse(response)
      JSON.parse response.to_s
    end

    def converted_link
      begin
        restclient_request.execute
      rescue => e
        puts "Sorry, Service is not available now. Please try again later"
      end
    end

    def restclient_request
      RestClient::Request.new(
        method: HTTP_METHOD,
        url: FSHARE_KILLER_URL,
        payload: {
          url: @url,
          type: FORM_TYPE,
          password:''
        }
      )
    end
  end
end
