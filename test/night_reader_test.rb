require 'minitest'
require 'night_reader'

class NightReaderTest < Minitest::Test
  def setup
    @converter = NightReader.new
  end

  def test_takes_in_1_braille_char_and_returns_char
    braille_a = "0.\n..\n.."

    @converter.convert_braille(braille_a)

    assert_equal "a", @converter.current_sentence
  end

  def test_takes_in_2_braille_chars_and_returns_chars
    braille_ab = "0.0.\n..0.\n...."

    @converter.convert_braille(braille_ab)

    assert_equal "ab", @converter.current_sentence
  end
end
