# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin 
Admin.create!(email: 'admin@teachermarkmate.com', password: 'admin@123')

SubscriptionType.create(name: "Individual Plan", description: '', price: '19.99', yearly_price: '239.88', no_of_printers: '1', sort_order: '1')

SubscriptionType.create(name: "5 Users Plan", description: '', price: '69.99', yearly_price: '839.88', no_of_printers: '1', sort_order: '2')

SubscriptionType.create(name: "10 Users Plan", description: '', price: '129.99', yearly_price: '1559.88', no_of_printers: '1', sort_order: '3')

SubscriptionType.create(name: "20 Users Plan", description: '', price: '249.99', yearly_price: '2999.88', no_of_printers: '1', sort_order: '4')
