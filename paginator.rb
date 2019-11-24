def get_book_pages(number_of_content_pages)
  number_of_content_pages = number_of_content_pages.to_i + 2 # plus front and back cover

  multiplier = number_of_content_pages / 4
  modulus = number_of_content_pages % 4

  if modulus > 0
    multiplier = multiplier + 1
  end

  actual_number_of_pages = multiplier * 4

  number_of_blank_pages = actual_number_of_pages - number_of_content_pages
  result_array = [actual_number_of_pages, number_of_blank_pages]

end

def pagination(actual_number_of_pages)

  number_of_sheets = actual_number_of_pages / 2

  sheets = {}
  counter = 1

  while counter < number_of_sheets + 1

    if counter == 1
      sheets[1] = [1,actual_number_of_pages]
    else
      iseven = false
      if counter % 2 == 0
	iseven = true
      end

      prev_a = sheets[counter - 1][0]
      prev_b = sheets[counter - 1][1]

      if iseven
	sheets[counter] = [prev_b - 1, prev_a + 1]
      else
	sheets[counter] = [prev_b + 1, prev_a - 1]
      end
    end

    counter += 1
  end

  sheets
end

def add_number_blanks(number_of_content_pages,number_of_blank_pages)
  number_of_content_pages = number_of_content_pages + number_of_blank_pages
  number_of_content_pages
end
