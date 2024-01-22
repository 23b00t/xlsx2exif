require 'mini_exiftool'
require_relative 'read_table'

module Xlsx2exif
  class PhotoProcessor
    def initialize(table_path)
      @table_path = table_path
      @exif_data = {}
    end

    def run(folder_path)
      read_table
      process_photos(folder_path)
    end

    private

    def read_table
      read_table = ReadTable.new(@table_path)
      @exif_data = read_table.run
    end

    def process_photos(folder_path)
      Dir.glob(File.join(folder_path, '*')).each do |photo_path|
        process_photo(photo_path)
      end
    end

    def process_photo(photo_path)
      key = File.basename(photo_path)
      return unless @exif_data[key]

      exif = MiniExiftool.new(photo_path)

      @exif_data[key].each do |tag, value|
        exif.public_send("#{tag}=", value)
      end

      exif.save
    end
  end
end
