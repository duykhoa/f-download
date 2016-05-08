require 'test_helper'

class TestShare < Minitest::Test
  def test_download
    Fshare::LinkConverter.stub :convert, "https://direct_link" do
      Fshare::Downloader.stub :download, :download_file do
        assert_equal Fshare.download('http://fshare.vn/afsd'), :download_file
      end
    end
  end
end
