class Word
  include Mongoid::Document
  field :mandarin_traditional, type: String
  field :mandarin_simplified, type: String
  field :mandarin_length, type: Integer
  field :pinyin, type: String
  field :english, type: String

  def accented_pinyin
  	pinyin.split.map{|p| accented(p) }.join ' ' 
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