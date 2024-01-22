require 'mini_exiftool'
require_relative 'read_table'

module Xlsx2exif
  # The PhotoProcessor class orchestrates the processing of photos based on EXIF data from an Excel table.
  class PhotoProcessor
    # Initializes a new instance of the PhotoProcessor class.
    #
    # @param table_path [String] The path to the Excel table file.
    def initialize(table_path)
      @table_path = table_path
      @exif_data = {}
    end

    # Runs the photo processing workflow by reading EXIF data from the Excel table
    # and applying it to the corresponding photos in the specified folder.
    #
    # @param folder_path [String] The path to the folder containing photos.
    def run(folder_path)
      read_table
      process_photos(folder_path)
    end

    private

    # Reads EXIF data from the Excel table and stores it in the @exif_data instance variable.
    def read_table
      read_table = ReadTable.new(@table_path)
      @exif_data = read_table.run
    end

    # Processes all photos in the specified folder by applying EXIF data from the @exif_data hash.
    #
    # @param folder_path [String] The path to the folder containing photos.
    def process_photos(folder_path)
      Dir.glob(File.join(folder_path, '*')).each do |photo_path|
        process_photo(photo_path)
      end
    end

    # Processes an individual photo by updating its EXIF data based on the @exif_data hash.
    #
    # @param photo_path [String] The path to the photo file.
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
