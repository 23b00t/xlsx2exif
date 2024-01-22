require_relative "../lib/read_table.rb"

p Xlsx2exif::ReadTable.new("./test/data.xlsx").run
