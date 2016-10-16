#!/usr/bin/env ruby

# Count number of words in a given files
# (regardless font case)
def word_count(file)
  wc = Hash.new(0)
  File.open(file, 'r') do |f|
    f.each_line do |line|
      line.split.each do |word|
        word = word.gsub(/[^a-zA-Z]/, '').downcase
        wc[word.to_sym] += 1
      end
    end
  end
  wc
end
