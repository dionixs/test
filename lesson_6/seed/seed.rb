s1 = Station.new('Тверь')
s2 = Station.new('Москва')
s3 = Station.new('Хабаровск')
s4 = Station.new('Чебоксары')
s5 = Station.new('Казань')

t1 = PassengerTrain.new('aa1-bb')
t2 = PassengerTrain.new('a21-ab')
t3 = CargoTrain.new('c21cc')
t4 = CargoTrain.new('c2124')

r1 = Route.new(s1, s2)
r2 = Route.new(s2, s5)
r2.add_station(s4)

t1.add_route(r1)
t2.add_route(r2)
t3.add_route(r2)
t4.add_route(r2)
