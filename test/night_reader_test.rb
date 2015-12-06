require 'minitest'
require 'night_reader'

class NightReaderTest < Minitest::Test
  def test_takes_in_1_braille_char_and_returns_char
    @converter = NightReader.new
    braille_a = "0.\n..\n.."

    @converter.convert_braille(braille_a)

    assert_equal "a", @converter.current_sentence
  end
end
