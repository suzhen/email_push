require 'roo'

spreadsheetx = Roo::Spreadsheet.open('./clients.xlsx')

header = spreadsheetx.row(2)

(3..spreadsheetx.last_row).each do |i|

   name =  spreadsheetx.row(i)[1]
   title = spreadsheetx.row(i)[2]
   company = spreadsheetx.row(i)[3]
   address = spreadsheetx.row(i)[4]
   email = spreadsheetx.row(i)[5]
   postcode = spreadsheetx.row(i)[6]

   puts "姓名：#{name}"
   puts "职位：#{title}"
   puts "公司：#{company}"
   puts "地址：#{address}"
   puts "邮箱：#{email}"
   puts "邮编：#{postcode}"

   Client.create(:name=>name.gsub(/\s*/, ''),:title=>title,:company=>company,:address=>address,:email=>email,:postcode=>postcode)


     # row = Hash[[header, spreadsheetx.row(i)].transpose]
     # puts row
 end