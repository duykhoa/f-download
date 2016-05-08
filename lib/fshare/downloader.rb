module Fshare
  class Downloader
    def self.download(url)
      new(url).download
    end

    def initialize(url)
      @url = url
    end

    def download
      uri = URI(@url)

      http_object = Net::HTTP.new(uri.host, uri.port)
      http_object.use_ssl = true if uri.scheme == 'https'

      http_object.start do |http|
        pbar = ProgressBar.create(title: base_name, total: http.request_head(@url)['content-length'].to_i)
        request = Net::HTTP::Get.new uri

        http.request request do |response|
          File.open base_name, 'w' do |io|
            response.read_body do |chunk|
              io.write chunk
              pbar.progress += chunk.size
            end
          end
        end
      end
    end

    def base_name
      #File.basename @url
      File.join(DOWNLOAD_DIR, File.basename(@url))
    end
  end
end
