require 'minitest'
require 'night_writer'

class NightWriterTest < Minitest::Test
  def setup
    @converter = NightWriter.new
  end

  def test_takes_in_1_char_and_returns_1_braille
    # We pass in the character we want converted
    braille_sentence = @converter.convert_word("a")

    # It should match the correct braille version
    assert_equal braille_sentence, "0.\n..\n.."
  end

  def test_takes_in_2_chars_and_returns_braille
    # We pass in the two characters we want converted
    braille_sentence = @converter.convert_word("ab")

    # It should match the correct braille version
    assert_equal braille_sentence, "0.0.\n..0.\n...."
  end
end
