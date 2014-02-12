namespace :import do
  desc "imports the cedict database"
  task words: :environment do

    Word.destroy_all
  	
  	File.open('lib/cedict_ts.u8', 'r').each do |line| 
  		next if is_comment line

      begin
        word = Word.from_line line
        word.save!
        puts word.mandarin_simplified
      rescue
        puts "failed to import: #{line}"
      end
  	end
  end
end

def is_comment(line)
  line.starts_with? '#'
end