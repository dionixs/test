letters = ('A'..'Z').to_a

vowels = {}

letters.each_with_index do |letter, index|
  letter = letter.downcase
  vowels[letter] = index + 1 if %w[a e i o u].include?(letter)
end

puts vowels
