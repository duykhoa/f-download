module Fshare
  class LinkConverter
    def self.convert(url)
      new(url).convert
    end

    def initialize(url = '')
      @url = url
    end

    def convert
      parse converted_link
    end

    def parse(response)
      JSON.parse response.to_s
    end

    def converted_link
      RestClient::Request.new(
        method: HTTP_METHOD,
        url: FSHARE_KILLER_URL,
        payload: {
          url: @url,
          type: FORM_TYPE,
          password:''
        }
      ).execute
    end
  end
end
