require 'minitest'
require 'night_writer'

class NightWriterTest < Minitest::Test
  def setup
    @converter = NightWriter.new
  end

  def test_takes_in_1_char_and_returns_braille
    # We pass in the character we want converted
    braille_sentence = @converter.convert_sentence("a")

    # It should match the correct braille version
    assert_equal braille_sentence, "0.\n..\n.."
  end

  def test_takes_in_2_chars_and_returns_braille
    # We pass in the two characters we want converted
    braille_sentence = @converter.convert_sentence("ab")

    # It should match the correct braille version
    assert_equal braille_sentence, "0.0.\n..0.\n...."
  end

  def test_takes_in_a_word_and_returns_braille
    # We pass in the two characters we want converted
    braille_sentence = @converter.convert_sentence("julian")

    # It should match the correct braille version
    assert_equal braille_sentence, ".00.0..00.00\n00..0.0....0\n..000.....0."
  end

  def test_accounts_for_spaces_in_the_sentence
    # We pass in the two characters we want converted
    braille_sentence = @converter.convert_sentence("max and emma")

    # It should match the correct braille version
    assert_equal braille_sentence, "000.00..0.0000..0.00000.\n...........0.0...0......\n0...00....0.......0.0..."
  end
end
