require 'pry'
require_relative 'file_helper'
require_relative 'characters'

class NightReader
  attr_accessor :current_sentence
  attr_reader :file_helper

  def initialize
    @current_sentence = ""
    @file_helper = FileHelper.new
  end

  def sentence
    file_helper.read
  end

  def multi_line?(sentence)
    sentence.include?("\n\n\n")
  end

  def split_multi_line(sentence)
    sentence.split("\n\n\n")
  end


  def convert_braille(braille_sentence=sentence)
    shift = false
    first_line  = ""
    second_line = ""
    third_line  = ""

    if multi_line?(braille_sentence)
      # iterate through multi_line & split on "\n"
      multi_line = split_multi_line(braille_sentence)
      multi_line.each do |line|
        lines = line.split("\n")
        first_line  += lines[0]
        second_line += lines[1]
        third_line  += lines[2]
      end
    else
      first_line, second_line, third_line = braille_sentence.split("\n")
    end

    until first_line == ""
      current_character = ""
      current_character += first_line.slice!(0..1)
      current_character += second_line.slice!(0..1)
      current_character += third_line.slice!(0..1)

      if current_character == ".....0"
        shift = true
        next
      elsif shift == true
        self.current_sentence += Characters::BRAILLE[current_character].upcase
        shift = false
      else
        self.current_sentence += Characters::BRAILLE[current_character]
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
