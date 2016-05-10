require 'bundler/setup'

require 'rest-client'
require 'net/http'
require 'ruby-progressbar'

module Fshare
  require File.dirname(__FILE__) + '/fshare/config'
  require File.dirname(__FILE__) + '/fshare/downloader'
  require File.dirname(__FILE__) + '/fshare/link_converter'
  require File.dirname(__FILE__) + '/fshare/folder_link_extractor'

  def self.download(url)
    direct_link = if url =~ /folder/
      FolderLinkExtractor.convert(url).join(' ')
    else
      LinkConverter.convert(url)
    end

    Downloader.download direct_link
  end

  def self.convert(url)
    result = if url =~ /folder/
      FolderLinkExtractor.convert(url)
    else
      LinkConverter.convert(url)
    end

    puts result
  end
end
