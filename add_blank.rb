require 'fileutils'

require_relative 'paginator.rb'

def split_pdf(pdf)
  @tmp_dir = "tmp/"

  FileUtils.mkdir_p @tmp_dir
  FileUtils.cp pdf, @tmp_dir

  `cd #{@tmp_dir}; pdftk "#{pdf}" burst`
end

def insert_blanks(tmp_dir)

  pdf_pages = Dir.glob(@tmp_dir + 'pg_0*.pdf')
  sorted = pdf_pages.sort

  len = sorted.length

  number_of_blanks = get_book_pages(len - 2)[1]

  last_page = sorted.sort[len - 1]

  counter = 0

  sorted.pop

  while counter < number_of_blanks
    sorted.push("blank.pdf")
    counter += 1
  end

  sorted.push(last_page)

  pages_list = sorted.join(" ")

  FileUtils.mkdir_p 'output'

  `pdftk #{pages_list} output output/tmp_blanks.pdf`

end

def get_book_name(pdf)
  File.basename(pdf).gsub(/\.pdf$/,"").gsub(/\s/, "_")
end

def add_blank_pages(pdf)
  split_pdf(pdf)
  insert_blanks(@tmp_dir)

  FileUtils.rm_rf(@tmp_dir)

  puts "  Blank pages added to PDF."
end
