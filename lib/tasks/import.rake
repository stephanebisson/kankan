namespace :import do
  desc "imports the cedict database"
  task words: :environment do
  	line_re = /^(?<chinese>.*?)\s\[(?<pinyin>.*?)\]\s\/(?<english>.*?)$/
  	File.open('lib/cedict_ts.u8', 'r').each do |line| 
  		next if line.starts_with? '#'

  		parts = line.match line_re

  		Word.create! \
  			mandarin_traditional: parts['chinese'].split.first, 
  			mandarin_simplified: parts['chinese'].split.last, 
  			mandarin_length: parts['chinese'].split.last.length, 
  			pinyin: parts['pinyin'], 
  			english: parts['english']

  		puts parts['chinese'].split.last
  	end
  end

end
