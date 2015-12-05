require 'minitest'
require 'night_writer'

class NightWriterTest < Minitest::Test
  def setup
    @converter = NightWriter.new
  end

  def test_returns_message_with_name_of_file_and_character_length
    skip
    # We pass in the character we want converted
    @converter.convert_sentence("abc")

    # Should give us back a formatted string w/ filename and character length
    # Not sure how to test the filename w/o placing an ARGV[0] in the class
    assert_equal @converter.format_output, "Created 'braille.txt' containing 20 characters"
  end

  def test_takes_in_1_char_and_returns_braille
    # We pass in the character we want converted
    @converter.convert_sentence("a")
    @converter.join_sentence

    # It should match the correct braille version
    assert_equal @converter.current_sentence, "0.\n..\n.."
  end

  def test_takes_in_2_chars_and_returns_braille
    # We pass in the two characters we want converted
    @converter.convert_sentence("ab")
    @converter.join_sentence

    # It should match the correct braille version
    assert_equal @converter.current_sentence, "0.0.\n..0.\n...."
  end

  def test_takes_in_a_word_and_returns_braille
    # We pass in the two characters we want converted
    @converter.convert_sentence("julian")
    @converter.join_sentence

    # It should match the correct braille version
    assert_equal @converter.current_sentence, ".00.0..00.00\n00..0.0....0\n..000.....0."
  end

  def test_accounts_for_spaces_in_the_sentence
    # We pass in the two characters we want converted
    @converter.convert_sentence("max and emma")
    @converter.join_sentence

    # It should match the correct braille version
    assert_equal @converter.current_sentence, "000.00..0.0000..0.00000.\n...........0.0...0......\n0...00....0.......0.0..."
  end

  def test_accounts_for_shift_character_for_1_char
    @converter.convert_sentence("A")
    @converter.join_sentence

    assert_equal @convert.current_sentence, "..0.\n....\n.0.."
  end
end
