#!/usr/bin/ruby

require 'fileutils'
require 'optparse'

require_relative 'paginator.rb'
require_relative 'add_blank.rb'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: bookletizer.rb [options]"

  opts.on("-f", "--filename FILE", "Source PDF filename") { |v| options[:filename] = v }
  opts.on("-o", "--output-dir DIR", "Output directory for PDF booklet") { |v| options[:output_dir] = v }
  opts.on("-l", "--letter-size", "Specify paper size as US letter (default A4)") { options[:letter_size] = true }

end.parse!

pdf = options[:filename]
if !pdf
  abort("  Please specify an input PDF file.")
elsif !File.exist?(pdf)
  abort("  Specified file not found.")
end

book_name = get_book_name(pdf) + "-booklet.pdf"

add_blank_pages(pdf)

blanks = "output/tmp_blanks.pdf"

letter_size = ""
if options[:letter_size]
  letter_size = " --paper letter"
end

`pdfbook#{letter_size} #{blanks}`

out_filename = "output/" + book_name

File.rename("tmp_blanks-book.pdf", out_filename)
File.delete(blanks)

if options[:output_dir]
  absolute_path = File.absolute_path(options[:output_dir]) + "/"
  if !Dir.exist?(absolute_path)
    abort("  Specified output directory does not exist.")
  end
  FileUtils.mv(out_filename, absolute_path)
end

puts "  Created booklet #{book_name}"
