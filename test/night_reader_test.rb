require 'minitest'
require 'night_reader'

class NightReaderTest < Minitest::Test
  def setup
    @converter = NightReader.new
  end

  def test_takes_in_1_braille_char_and_returns_english_char
    braille_a = "0.\n..\n.."

    @converter.convert_braille(braille_a)

    assert_equal "a", @converter.current_sentence
  end

  def test_takes_in_2_braille_chars_and_returns_english_chars
    braille_ab = "0.0.\n..0.\n...."

    @converter.convert_braille(braille_ab)

    assert_equal "ab", @converter.current_sentence
  end

  def test_takes_in_a_braille_word_and_returns_english_word
    braille_word = ".00.0..00.00\n00..0.0....0\n..000.....0."

    @converter.convert_braille(braille_word)

    assert_equal "julian", @converter.current_sentence
  end

  def test_reads_braille_spaces_into_english_spaces
    braille_word_with_spaces = "000.00..0.0000..0.00000.\n...........0.0...0......\n0...00....0.......0.0...."

    @converter.convert_braille(braille_word_with_spaces)

    assert_equal "max and emma", @converter.current_sentence
  end
end
