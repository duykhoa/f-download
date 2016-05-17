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
        leecher
      rescue => e
        puts "Sorry, Service is not available now. Please try again later"
      end
    end

    def leecher
      uri = URI(FSHARE_KILLER_URL)
      req = Net::HTTP::Post.new(uri)
      req['Referer'] = FSHARE_KILLER_URL_REFERER
      req.set_form_data(data)

      res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(req)
      end

      res.body
    end

    def data
      {
        url: @url,
        password: '',
        type: :file
      }
    end
  end
end
