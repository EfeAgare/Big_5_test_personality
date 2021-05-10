require 'spec_helper'
require_relative '../personality_result_html_to_json'

RSpec.describe PersonalityResultHtmlToJson do
  describe '#execute' do
    let(:html_file) { File.expand_path("../../The_five_factor_model_of_personality.html",  __FILE__)}
    let(:json_data) { JSON.parse(File.read(File.expand_path('../../personality_result.json', __FILE__)))}
    let(:result) { PersonalityResultHtmlToJson.new(html_file).execute }

    it 'returns true for the result hash' do

      expect(result.is_a?(Hash)).to eq(true)
    end

    it 'returns true for result length' do

      expect(result.length()).to eq(json_data.length())
    end

    it 'returns true for result name and email' do

      expect(result["NAME"]).to eq(json_data["NAME"])
      expect(result["EMAIL"]).to eq(json_data["EMAIL"])
    end

    it 'returns true for result EXTRAVERSION' do

      expect(result["EXTRAVERSION"]).to eq(json_data["EXTRAVERSION"])
    end

    it 'returns true for result EXTRAVERSION Facets length' do

      expect(result["EXTRAVERSION"]["Facets"].length()).to eq(json_data["EXTRAVERSION"]["Facets"].length())
    end
  end
end
