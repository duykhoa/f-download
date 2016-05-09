module Fshare
  class Downloader
    def self.download(url)
      new(url).download
    end

    def initialize(url)
      @url = url
    end

    def download
      `wget #{@url} -P #{DOWNLOAD_DIR}`
    end

    def base_name
      File.join(DOWNLOAD_DIR, File.basename(@url))
    end
  end
end
