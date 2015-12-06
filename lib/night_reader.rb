require 'pry'
require_relative 'file_helper'

class NightReader
  attr_accessor :current_sentence
  attr_reader :braille_chars, :file_helper

  def initialize
    @current_sentence = ""
    @braille_chars = {
      "0....." => "a",
      "0.0..." => "b"
    }
    @file_helper = FileHelper.new
  end

  def sentence
    file_helper.read
  end

  def convert_braille(braille_sentence=sentence)
    first_line, second_line, third_line = braille_sentence.split("\n")

    until first_line == ""
      current_character = ""
      current_character += first_line.slice!(0..1)
      current_character += second_line.slice!(0..1)
      current_character += third_line.slice!(0..1)

      self.current_sentence += braille_chars[current_character]
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
