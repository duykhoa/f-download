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
        size = http.request_head(@url)['content-length'].to_i
        pbar = ProgressBar.create(
          title: base_name,
          total: size,
          format: "%a %B %p%% %t Total #{size/(1024**2)} MB"
        )
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
      File.join(DOWNLOAD_DIR, File.basename(@url))
    end
  end
end
