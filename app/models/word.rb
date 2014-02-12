require 'ting/string'

class Word
  include Mongoid::Document
  field :t, as: :mandarin_traditional, type: String
  field :s, as: :mandarin_simplified, type: String
  field :p, as: :pinyin, type: String
  field :e, as: :english, type: String

  def self.from_line(line)
    line_re = /^(?<chinese>.*?)\s\[(?<pinyin>.*?)\]\s\/(?<english>.*?)\//
    parts = line.match line_re

    new \
        mandarin_traditional: parts['chinese'].split.first, 
        mandarin_simplified: parts['chinese'].split.last, 
        pinyin: to_pinyin(parts['pinyin']),
        english: to_pinyin(parts['english'])
  end

  def self.random
    Word.skip(Random.rand(Word.count)).first
  end

  def to_s
    "#{mandarin_simplified} (#{pinyin})"
  end

  private 

  def self.to_pinyin(word)
    word.pretty_tones rescue word
  end

end