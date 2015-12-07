require 'minitest'
require 'night_reader'
require 'night_writer'

class NightReaderTest < Minitest::Test
  def setup
    @converter = NightReader.new
    @english_converter = NightWriter.new
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

  def test_properly_shifts_capital_braille_char_into_capital_english_char
    braille_A = "..0.\n....\n.0.."

    @converter.convert_braille(braille_A)

    assert_equal "A", @converter.current_sentence
  end

  def test_properly_shifts_two_capital_braille_chars_into_capital_english_chars
    braille_AA = "..0...0.\n........\n.0...0.."

    @converter.convert_braille(braille_AA)

    assert_equal "AA", @converter.current_sentence
  end

  def test_properly_converts_braille_special_chars_to_capital_special_chars
    braille_special_chars = "..............\n..00..0...000.\n..0.0...00.000"

    @converter.convert_braille(braille_special_chars)

    assert_equal " !',-.?", @converter.current_sentence
  end

  def test_properly_converts_long_multi_line_braille_chars_to_english_chars
    @english_converter.convert_sentence("Here is some really long text that is going to get cut off in Night Reader! If it doesn't get cut off then it will hopefull print on another line.")
    braille_sentence = @english_converter.join_sentence

    @converter.convert_braille(braille_sentence)

    assert_equal "Here is some really long text that is going to get cut off in Night Reader! If it doesn't get cut off then it will hopefull print on another line.", @converter.current_sentence
  end
end
