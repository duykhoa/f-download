require 'bundler/setup'

require 'rest-client'
require 'net/http'
require 'ruby-progressbar'

module Fshare
  require File.dirname(__FILE__) + '/fshare/config'
  require File.dirname(__FILE__) + '/fshare/downloader'
  require File.dirname(__FILE__) + '/fshare/link_converter'

  def self.download(url)
    direct_link = LinkConverter.convert(url)
    Downloader.download direct_link
  end

  def self.convert(url)
    puts LinkConverter.convert(url)
  end
end
