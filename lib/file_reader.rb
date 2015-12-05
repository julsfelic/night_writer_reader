class FileHelper
  def read
    filename = ARGV[0]
    File.read(filename).chomp
  end

  def write(sentence)
    filename = ARGV[1]
    File.open(filename, "w") { |f| f.puts sentence }
  end
end
