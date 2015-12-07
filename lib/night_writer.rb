require 'pry'
require_relative 'file_helper'
require_relative 'characters'

class NightWriter
  attr_accessor :current_sentence
  attr_reader :file_helper

  def initialize
    # there is a hash method that switches keys and values USE IT IN night reader
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
    multi_line  =  []

    english_sentence.each_char do |char|
      # if char == char.upcase && char != " "
      if char == char.upcase && !" !',-.?".include?(char)
        first_line  << [".."]
        second_line << [".."]
        third_line  << [".0"]
        char = char.downcase
      end

      braille_frag = Characters::ENGLISH[char]
      first_line << braille_frag[0]
      second_line << braille_frag[1]
      third_line << braille_frag[2]
    end

    first_line  = first_line.join
    second_line = second_line.join
    third_line  = third_line.join

    if first_line.length > 80
      i = first_line.length / 81

      # use some type of until loop until slice! return nil or ""
      # gets rid of if and first_line.length / 81

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
    "Created '#{file_helper.current_write_file}' containing #{current_sentence.length} characters"
  end
end

if __FILE__ == $0
  converter = NightWriter.new
  converter.convert_sentence
  converter.return_output
end
