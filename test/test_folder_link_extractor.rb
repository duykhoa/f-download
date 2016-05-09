require 'test_helper'

class TestFolderLinkExtractor< Minitest::Test
  def setup
    @url = "https://www.fshare.vn/folder/59M12X96VJS3"
    @converter = Fshare::FolderLinkExtractor.new(@url)
  end

  def test_convert
    @converter.convert
  end
end
