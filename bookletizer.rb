#!/usr/bin/ruby

require 'fileutils'
require 'optparse'

require_relative 'paginator.rb'
require_relative 'add_blank.rb'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: bookletizer.rb [options]"

  opts.on("-l", "--letter-size", "Specify paper size as US letter (default A4)") { options[:letter_size] = true }

end.parse!

pdf = ARGV[0]

book_name = get_book_name(pdf) + "-booklet.pdf"

add_blank_pages(pdf)

blanks = "output/tmp_blanks.pdf"

letter_size = ""
if options[:letter_size]
  letter_size = " --paper letter"
end

`pdfbook#{letter_size} #{blanks}`

File.rename("tmp_blanks-book.pdf", "output/" + book_name)
File.delete(blanks)

puts "  Created booklet #{book_name}"
