require "nokogiri"
require 'json'
require_relative 'constant'

class PersonalityResultHtmlToJson
  def initialize(file_data)
    @result_html_file = file_data
    @section_details = []
    @details_hash = { "NAME" => NAME, "EMAIL" => EMAIL }
    @result_section_details = []
  end

  def execute
    personality_result_section
    personality_result_section_details
    section_details
    write_to_json_file
    @details_hash
  end

  def personality_result_section
    result_html = File.read(@result_html_file)
    document = Nokogiri::HTML(result_html)
    @result_section_details  = document.css(".graph-txt").children
  end


  def personality_result_section_details
    @result_section_details.each_with_index do |personality_detail|
      text = personality_detail.children.inner_text
      @section_details << text.tr("\n\t+","") unless text.empty?
    end
  end

  def section_details
    @section_details.each do |detail|
      detail_array =  detail.gsub(/[^0-9a-z\- ]/i, '').split(/(\d+)/)
      detail_array = detail_array[0...detail_array.length-1]
      detail_array[0] = detail_array[0].split("Score")[1]
      detail_array = detail_array.each_slice(2).to_a
      build_json(detail_array)
    end
  end

  def build_json(detail_array)
    detail_array = detail_array.flatten
    @details_hash[detail_array[0]] = {}
    @details_hash[detail_array[0]]["Overall Score"] = {}
    @details_hash[detail_array[0]]["Overall Score"] = detail_array[1].to_i
    @details_hash[detail_array[0]]["Facets"] = {}
    @details_hash[detail_array[0]]["Facets"][detail_array[2].strip] = detail_array[3].to_i
    @details_hash[detail_array[0]]["Facets"][detail_array[4].strip] = detail_array[5].to_i
    @details_hash[detail_array[0]]["Facets"][detail_array[6].strip] = detail_array[7].to_i
    @details_hash[detail_array[0]]["Facets"][detail_array[8].strip] = detail_array[9].to_i
    @details_hash[detail_array[0]]["Facets"][detail_array[10].strip] = detail_array[11].to_i
    @details_hash[detail_array[0]]["Facets"][detail_array[12].strip] = detail_array[13].to_i
  end

  def write_to_json_file
    File.write("personality_result.json", JSON.pretty_generate(@details_hash))
  end
end
