require 'test_helper'

class TestLinkConverter < Minitest::Test
  def setup
    @response = '{"url":"http:\/\/download013.fshare.vn\/dl\/RjrO4NLVbkILMLmQQ5-xtdBGaQ5TB8ZzPjgPRrFJdmRm93GPyT6Hergzu-q9dXvfrMt594Yo+0xPIc5g\/Xem%20phim%20V%E1%BB%81%20Qu%C3%AA%20%28Ho%C3%A0i%20T%C3%A2m%20-%20Vi%E1%BB%87t%20H%C6%B0%C6%A1ng%29%20-%20Paris%20By%20Night%2095%20_%20Fsharefilm.com.MP4","msg":"OK","fileSize":"146.7 MB","isVideo":false} '

    @url = "https://www.fshare.vn/file/I5TGK87YYOB5"
    @converter = Fshare::LinkConverter.new(@url)
  end

  def test_convert
    Fshare::LinkConverter.stub :new, @converter do
      @converter.stub :converted_link, @response do
        convert_response = Fshare::LinkConverter.new(@url).convert

        assert_equal convert_response, JSON.parse(@response)
      end
    end
  end
end
