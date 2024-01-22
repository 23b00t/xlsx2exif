require_relative '../lib/photo_processor'

table_path = ARGV[0] # Path to the XLSX file
folder_path = ARGV[1] # Path to the folder containing photos

if table_path.nil? || folder_path.nil?
  puts "Usage: ruby bin/app.rb path/to/table.xlsx path/to/photos_folder"
  exit(1)
end

processor = Xlsx2exif::PhotoProcessor.new(table_path)

runs = 1
# Start a thread to display the progress
status_thread = Thread.new do
  loop do
    print "\e[42m\e[97m\rProcessing... #{runs} files prcessed!\e[0m"
    sleep(0.5)
    runs += 0.5
  end
end

# Run the processor
processor.run(folder_path)

# Stop the thread after the processor finishes
status_thread.exit

puts "\n\n"

# Check for success and output corresponding messages
if processor.no_photo_found.empty? && processor.exif_data.empty?
  puts "\e[32mDone successfully! :)\e[0m"
else
  puts "\e[32mFinished without errors,\e[0m\e[33m but not all data could be processed:\e[0m"

  puts "\e[31mPhotos without associated data:\e[0m"
  puts processor.no_photo_found.join(' ') unless processor.no_photo_found.empty?
  puts ""
  puts "\e[31mData without associated photos:\e[0m"
  puts processor.exif_data.keys.join(' ') unless processor.exif_data.empty?
end
