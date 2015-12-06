require 'pry'
require_relative 'file_helper'

class NightReader
  attr_accessor :current_sentence
  attr_reader :braille_chars, :file_helper

  def initialize
    @current_sentence = ""
    @braille_chars = {
      "0....." => "a"
    }
    @file_helper = FileHelper.new
  end

  def sentence
    file_helper.read
  end

  def convert_braille(braille_sentence=sentence)
    braille_sentence_without_newlines = braille_sentence.gsub("\n", "")
    self.current_sentence = braille_chars[braille_sentence_without_newlines]
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
