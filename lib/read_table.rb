module Xlsx2exif
  require 'roo'
  class ReadTable
    def initialize(path)
      @path = path
      @data = {}
    end

    # Public method to initiate the reading process
    def run
      open_file
      pars_content
      @data
    end

    private

    # Open the Excel file
    def open_file
      file_path = File.expand_path(@path, __dir__)

      raise "File not found: #{@path}" unless File.exist?(@path)

      begin
        @file = Roo::Excelx.new(@path)
      rescue Roo::Excelx::Error => e
        raise "Error opening Excel file: #{e.message}"
      end
    end

    # Parse the content of the Excel file into a hash
    def pars_content
      init_filenames
      init_headers
      @file_names.each do |row|
        key = row[0]
        values = {}

        @headers.each_with_index do |header, index|
          values[header] = row[index + 1] || ""
        end

        @data[key] = values
      end
    end

    # Initialize the filenames for processing
    def init_filenames
      @file_names = (2..@file.last_row).map { |row_index| @file.row(row_index) }
    end

    # Initialize the headers for processing
    def init_headers
      @headers = @file.row(1)[1..-1]
    end
  end
end
