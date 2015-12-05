require 'pry'
require_relative 'file_helper'

class NightWriter
  attr_accessor :current_sentence
  attr_reader :braille_chars, :file_helper

  def initialize
    @braille_chars = {
      "a" => ["0.", "..", ".."],
      "b" => ["0.", "0.", ".."],
      "c" => ["00", '..', '..'],
      "d" => ["00", ".0", ".."],
      "e" => ["0.", ".0", ".."],
      "f" => ["00", "0.", ".."],
      "g" => ["00", "00", ".."],
      "h" => ["0.", "00", ".."],
      "i" => [".0", "0.", ".."],
      "j" => [".0", "00", ".."],
      "k" => ["0.", "..", "0."],
      "l" => ["0.", "0.", "0."],
      "m" => ["00", "..", "0."],
      "n" => ["00", ".0", "0."],
      "o" => ["0.", ".0", "0."],
      "p" => ["00", "0.", "0."],
      "q" => ["00", "00", "0."],
      "r" => ["0.", "00", "0."],
      "s" => [".0", "0.", "0."],
      "t" => [".0", "00", "0."],
      "u" => ["0.", "..", "00"],
      "v" => ["0.", "0.", "00"],
      "w" => [".0", "00", ".0"],
      "x" => ["00", "..", "00"],
      "y" => ["00", ".0", "00"],
      "z" => ["0.", ".0", "00"],
      " " => ["..", "..", ".."]
    }
    @current_sentence = []
    @file_helper = FileHelper.new
  end

  def sentence
    file_helper.read
  end

  def convert_sentence(english_sentence = sentence)
    if english_sentence.length == 1
      braille_frag = braille_chars[english_sentence]
      braille_frag.each do |braille|
        self.current_sentence << braille
      end
    else
      first_line  =  []
      second_line =  []
      third_line  =  []

      english_sentence.each_char do |char|
        braille_frag = braille_chars[char]
        first_line  << braille_frag[0]
        second_line << braille_frag[1]
        third_line  << braille_frag[2]
      end

      current_sentence << [first_line.join]
      current_sentence << [second_line.join]
      current_sentence << [third_line.join]
    end

    current_sentence.join("\n")
  end

  def return_output
    file_helper.write(current_sentence)
  end
end

if __FILE__ == $0
  @converter = NightWriter.new
  @converter.convert_sentence
  @converter.return_output
end
