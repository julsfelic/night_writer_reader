require 'pry'
require_relative 'file_helper'

class NightReader
  attr_accessor :current_sentence
  attr_reader :braille_chars, :file_helper

  def initialize
    @current_sentence = ""
    @braille_chars = {
      "0....." => "a",
      "0.0..." => "b",
      "00...." => "c",
      "00.0.." => "d",
      "0..0.." => "e",
      "000..." => "f",
      "0000.." => "g",
      "0.00.." => "h",
      ".00..." => "i",
      ".000.." => "j",
      "0...0." => "k",
      "0.0.0." => "l",
      "00..0." => "m",
      "00.00." => "n",
      "0..00." => "o",
      "000.0." => "p",
      "00000." => "q",
      "0.000." => "r",
      ".00.0." => "s",
      ".0000." => "t",
      "0...00" => "u",
      "0.0.00" => "v",
      ".000.0" => "w",
      "00..00" => "x",
      "00.000" => "y",
      "0..000" => "z",
      "......" => " ",
      "..000." => "!",
      "....0." => "'",
      "..0..." => ",",
      "....00" => "-",
      "..00.0" => ".",
      "..0.00" => "?"
    }
    @file_helper = FileHelper.new
  end

  def sentence
    file_helper.read
  end

  def convert_braille(braille_sentence=sentence)
    first_line, second_line, third_line = braille_sentence.split("\n")
    shift = false

    until first_line == ""
      current_character = ""
      current_character += first_line.slice!(0..1)
      current_character += second_line.slice!(0..1)
      current_character += third_line.slice!(0..1)

      if current_character == ".....0"
        shift = true
        next
      elsif shift == true
        self.current_sentence += braille_chars[current_character].upcase
        shift = false
      else
        self.current_sentence += braille_chars[current_character]
      end

    end
  end

  def return_output
    file_helper.write(current_sentence)
    puts format_output
  end

  def format_output
    "Created '#{ARGV[1]}' containing #{current_sentence.length} characters"
  end
end

if __FILE__ == $0
  @converter = NightReader.new
  @converter.convert_braille
  @converter.return_output
end
