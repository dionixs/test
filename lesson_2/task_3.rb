arr = Array.new

i = 0
j = 1

10.times do
  arr << i
  i, j = j, i + j
end

puts arr
