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
    first_line  =  []
    second_line =  []
    third_line  =  []
    multi_line  = []

    english_sentence.each_char do |char|
      if char == char.upcase && char != " "
        first_line  << [".."]
        second_line << [".."]
        third_line  << [".0"]
        char = char.downcase
      end

      braille_frag = braille_chars[char]
      first_line << braille_frag[0]
      second_line << braille_frag[1]
      third_line << braille_frag[2]
    end

    first_line  = first_line.join
    second_line = second_line.join
    third_line  = third_line.join

    if first_line.length > 80
      i = first_line.length / 81

      0.upto(i) do |n|
        multi_line << first_line.slice!(0..79)
        multi_line << second_line.slice!(0..79)
        multi_line << third_line.slice!(0..79)

        multi_line << "\n" unless n == i
      end
    else
      multi_line << first_line
      multi_line << second_line
      multi_line << third_line
    end

    # current_sentence << [first_line].join
    # current_sentence << [second_line].join
    # current_sentence << [third_line].join

    current_sentence << multi_line.join("\n")
  end

  def join_sentence
    self.current_sentence = current_sentence.join("\n")
  end

  def return_output
    join_sentence
    file_helper.write(current_sentence)
    puts format_output
  end

  def format_output
    "Created '#{ARGV[1]}' containing #{current_sentence.length} characters"
  end
end

if __FILE__ == $0
  @converter = NightWriter.new
  @converter.convert_sentence
  @converter.return_output
end
