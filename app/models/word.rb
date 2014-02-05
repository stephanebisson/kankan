class Word
  include Mongoid::Document
  field :t, as: :mandarin_traditional, type: String
  field :s, as: :mandarin_simplified, type: String
  field :l, as: :mandarin_length, type: Integer
  field :p, as: :pinyin, type: String
  field :e, as: :english, type: String
  field :h, as: :level, type: Hash
  field :el, as: :elected_level, type: Integer
  field :w, as: :nb_wrong, type: Integer

  def accented_pinyin
  	pinyin.split.map{|p| accented(p) }.join ' ' 
  end

  def vote_level(l)
    self.level ||= {}
    self.level[l] ||= 0
    self.level[l] = self.level[l] + 1
    update_level
  end

  def vote_wrong
    self.nb_wrong ||= 0
    self.nb_wrong = self.nb_wrong + 1    
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

  def self.random_uncategorized
    uncategorized = Word.where(level: nil)
    uncategorized.skip(Random.rand(uncategorized.count)).first
  end

  def self.random(size)
    right_size = Word.where(mandarin_length: size)
    right_size.skip(Random.rand(right_size.count)).first
  end

  private 

  def update_level
    self.elected_level = level.max_by{|k,v| v}.first
  end

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
      begin
    		re = /^(?<before>[^aeiou]*?)(?<first_vowels>[aeiou]*?)(?<last_vowel>[aeiou]{1})(?<after>[^aeiou]*)$/
    		parts = word.match re
    		word = "#{parts['before']}#{parts['first_vowels']}#{accents[parts['last_vowel'].to_sym][tone]}#{parts['after']}"
      rescue
      end
  	end

  	word
  end
end