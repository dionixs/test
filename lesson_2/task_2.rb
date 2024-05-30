arr = []

i = 0
k = 0

while i < 100
  i += 1
  k += 1
  while k == 5
    arr.push(i) if i >= 10
    k = 0
  end
end

puts arr.inspect
