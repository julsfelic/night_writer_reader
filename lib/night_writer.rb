require 'pry'
require_relative 'file_reader'

class NightWriter
  attr_accessor :current_word
  attr_reader :braille_chars, :file_helper

  def initialize
    @braille_chars = {
      "a" => ["0.", "..", ".."],
      "b" => ["0.", "..", ".."]
    }
    @current_word = []
    @file_helper = FileHelper.new
  end

  def word
    file_helper.read
  end

  def convert_word(english_word = word)
    if english_word.length == 1
      braille_frag = braille_chars[english_word]
      braille_frag.each do |braille|
        self.current_word << braille
      end
    else
      # implement shit
    end

    current_word.join("\n")
  end

  def return_output
    file_helper.write(current_word)
  end
end

if __FILE__ == $0
  @converter = NightWriter.new
  @converter.convert_word
  @converter.return_output
end
