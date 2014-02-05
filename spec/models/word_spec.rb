require 'spec_helper'

describe Word do
	it 'parses a line' do
		word = Word.from_line "char [pinyin] /english here/"

		word.english.should == "english here"
	end
end