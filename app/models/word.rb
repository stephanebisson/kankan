class Word
  include Mongoid::Document
  field :t, as: :mandarin_traditional, type: String
  field :s, as: :mandarin_simplified, type: String
  field :l, as: :mandarin_length, type: Integer
  field :p, as: :pinyin, type: String
  field :e, as: :english, type: String

  def accented_pinyin
  	pinyin.split.map{|p| accented(p) }.join ' ' 
  end

  def self.from_line(line)
    line_re = /^(?<chinese>.*?)\s\[(?<pinyin>.*?)\]\s\/(?<english>.*?)\//
    parts = line.match line_re

    new \
        mandarin_traditional: parts['chinese'].split.first, 
        mandarin_simplified: parts['chinese'].split.last, 
        mandarin_length: parts['chinese'].split.last.length, 
        pinyin: parts['pinyin'], 
        english: parts['english']
  end

  private 
  def accented(pinyin)
  	accents = {
  		a: ['ā', 'á', 'ǎ', 'à', 'a'],
  		e: ['ē', 'é', 'ě', 'è', 'e'],
  		o: ['ō', 'ó', 'ǒ', 'ò', 'o'],
  		i: ['ī', 'í', 'ǐ', 'ì', 'i'],
  		u: ['ū', 'ú', 'ǔ', 'ù', 'u']
  	}

  	word = pinyin[0..-2].gsub('u:', 'u').downcase
  	tone = pinyin[-1].to_i - 1
  	if word['a']
  		word['a'] = accents[:a][tone]
  	elsif word['e']
  		word['e'] = accents[:e][tone]
  	elsif word['ou']
  		word['ou'] = "#{accents[:o][tone]}u"
  	else
  		re = /^(?<before>[^aeiou]*?)(?<first_vowels>[aeiou]*?)(?<last_vowel>[aeiou]{1})(?<after>[^aeiou]*)$/
  		parts = word.match re
  		word = "#{parts['before']}#{parts['first_vowels']}#{accents[parts['last_vowel'].to_sym][tone]}#{parts['after']}"
  	end

  	word
  end
end