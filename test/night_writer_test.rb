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

  def test_takes_in_1_english_char_and_returns_braille_char
    # We pass in the character we want converted
    @converter.convert_sentence("a")
    @converter.join_sentence

    # It should match the correct braille version
    assert_equal "0.\n..\n..", @converter.current_sentence
  end

  def test_takes_in_2_english_chars_and_returns_braille_chars
    # We pass in the two characters we want converted
    @converter.convert_sentence("ab")
    @converter.join_sentence

    # It should match the correct braille version
    assert_equal "0.0.\n..0.\n....", @converter.current_sentence
  end

  def test_takes_in_an_english_word_and_returns_braille_word
    # We pass in the two characters we want converted
    @converter.convert_sentence("julian")
    @converter.join_sentence

    # It should match the correct braille version
    assert_equal ".00.0..00.00\n00..0.0....0\n..000.....0.", @converter.current_sentence
  end

  def test_reads_english_spaces_to_braille_spaces
    # We pass in the two characters we want converted
    @converter.convert_sentence("max and emma")
    @converter.join_sentence

    # It should match the correct braille version
    assert_equal "000.00..0.0000..0.00000.\n...........0.0...0......\n0...00....0.......0.0...", @converter.current_sentence
  end

  def test_properly_shifts_capital_english_char_into_capital_braille_char
    @converter.convert_sentence("A")
    @converter.join_sentence

    assert_equal "..0.\n....\n.0..", @converter.current_sentence
  end

  def test_properly_shifts_two_capital_english_char_into_braille_chars
    @converter.convert_sentence("AA")
    @converter.join_sentence

    assert_equal "..0...0.\n........\n.0...0..", @converter.current_sentence
  end

  def test_properly_converts_english_special_chars_to_braille_special_chars
    @converter.convert_sentence(" !',-.?")
    @converter.join_sentence

    assert_equal "..............\n..00..0...000.\n..0.0...00.000", @converter.current_sentence
  end

  def test_limits_line_to_80_chars
    long_line = "a" * 41
    @converter.convert_sentence(long_line)
    @converter.join_sentence

    first_line = []
    first_line << "0." * 40

    second_line = []
    second_line << ".." * 40

    third_line = []
    third_line << ".." * 40

    spacer = []
    spacer << "\n"

    fourth_line = []
    fourth_line << "0."

    fifth_line = []
    fifth_line << ".."

    sixth_line = []
    sixth_line << ".."

    multi_line = [
      first_line,
      second_line,
      third_line,
      spacer,
      fourth_line,
      fifth_line,
      sixth_line
    ].join("\n")

    assert_equal multi_line, @converter.current_sentence
  end
end
