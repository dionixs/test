s1 = Station.new('Тверь')
s2 = Station.new('Москва')
s3 = Station.new('Хабаровск')
s4 = Station.new('Чебоксары')
s5 = Station.new('Казань')

t1 = PassengerTrain.new('aa1-bb')
t2 = PassengerTrain.new('a21-ab')
t3 = CargoTrain.new('c21cc')
t4 = CargoTrain.new('c2124')

w1 = PassengerWagon.new { |p| p.total_seats = 100 }
w2 = PassengerWagon.new { |p| p.total_seats = 100 }
w3 = PassengerWagon.new { |p| p.total_seats = 100 }
w1.take_seat

w4 = CargoWagon.new { |p| p.total_volume = 66 }

r1 = Route.new(s1, s2)
r2 = Route.new(s2, s5)
r2.add_station(s4)

t1.add_route(r1)
t2.add_route(r2)
t3.add_route(r2)
t4.add_route(r2)

s1.take_train(t1)
s1.take_train(t2)
s1.take_train(t3)

t2.add_wagon(w1)
t2.add_wagon(w2)
t2.add_wagon(w3)

# s1.each_train { |t| puts t }
# t2.each_wagon { |w| puts w }
