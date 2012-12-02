# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Tag.create([
  { title: 'OSE' },
  { title: 'Intendencia Municipal de Montevideo' },
  { title: 'UTE' },
  { title: 'No me gusta nada' },
  { title: 'Todo es una mierda' }
])

Issue.create([
  { text: 'Esta computadora es una miera! #columbus' },
  { text: 'Quiero comer pizza! #columbus' },
  { text: 'Tengo suenio! #columbus' },
  { text: 'Nada me viene bien, por eso uso esta app!!! #columbus' }
]);
