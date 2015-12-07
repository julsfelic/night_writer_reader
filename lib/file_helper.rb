class FileHelper
  def read
    filename = current_read_file
    File.read(filename).chomp
  end

  def write(sentence)
    filename = current_write_file
    File.open(filename, "w") { |f| f.puts sentence }
  end

  def current_read_file
    ARGV[0]
  end

  def current_write_file
    ARGV[1]
  end
end
