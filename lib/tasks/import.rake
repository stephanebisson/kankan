namespace :import do
  desc "imports the cedict database"
  task words: :environment do
  	
  	File.open('lib/cedict_ts.u8', 'r').each do |line| 
  		next if is_comment line

      word = Word.from_line line
      word.save!
      puts word.mandarin_simplified
  	end
  end

end


def is_comment(line)
  line.starts_with? '#'
end