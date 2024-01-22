require_relative '../lib/photo_processor'

table_path = ARGV[0] # Pfad zur XLSX-Datei
folder_path = ARGV[1] # Pfad zum Ordner mit Fotos

if table_path.nil? || folder_path.nil?
  puts "Usage: ruby bin/app.rb path/to/table.xlsx path/to/photos_folder"
  exit(1)
end

processor = Xlsx2exif::PhotoProcessor.new(table_path)
processor.run(folder_path)
