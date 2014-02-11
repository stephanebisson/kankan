require 'ting/string'

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
    pinyin.pretty_tones
  end

  def english_with_pinyin
    english.pretty_tones
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

  def self.random(size, level=nil)
    right_size = Word.where(mandarin_length: size)

    if level.present?
      right_level = right_size.where(elected_level: level.to_i)
      return random_from_set(right_level) if right_level.exists?
    end

    random_from_set right_size
  end

  private 

  def self.random_from_set(set)
    set.skip(Random.rand(set.count)).first
  end

  def update_level
    self.elected_level = level.max_by{|k,v| v}.first
  end

end