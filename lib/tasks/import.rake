require 'nokogiri'

namespace :import do
  desc "imports the cedict database"
  task words: :environment do

    Word.destroy_all

    types = word_type_map
  	
  	File.open('lib/cedict_ts.u8', 'r').each do |line| 
  		next if is_comment line

      word = Word.from_line line
      freq = types[word.mandarin_simplified]
      if freq
        sum = freq.values.sum.to_f
        word.word_types = freq.map {|type, count| WordType.new type: type, frequency: count/sum }
      end
      word.save!
      puts "#{word.mandarin_simplified}  #{freq.nil? ? '-> unknown frequency' : ''}"
  	end
  end

  desc "creates word-type mapping"
  task type: :environment do
    word_type_map.each do |w, freq|
      word = Word.where(mandarin_simplified: w).first
      if word
        sum = freq.values.sum.to_f
        word.word_types = freq.map {|type, count| WordType.new type: type, frequency: count/sum }
        word.save!
      end
    end
  end
end

def word_type_map
  types = {}
  Dir.glob('lib/lcmc/character/*.XML') do |xml_file|
    puts "Parsing #{xml_file}"
    doc = Nokogiri::XML File.read(xml_file)
    doc.xpath('//w').each do |word|
      types[word.content] ||= {}
      types[word.content][word.at_xpath('@POS').content] ||= 0
      types[word.content][word.at_xpath('@POS').content] += 1
    end
  end
  types
end

def is_comment(line)
  line.starts_with? '#'
end