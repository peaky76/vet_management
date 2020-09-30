require_relative( "../models/appointment.rb" )
require_relative( "../models/owner.rb" )
require_relative( "../models/owner_product.rb" )
require_relative( "../models/payment.rb" )
require_relative( "../models/pet.rb" )
require_relative( "../models/pet_treatment.rb" )
require_relative( "../models/product.rb" )
require_relative( "../models/surgery.rb" )
require_relative( "../models/treatment.rb" )
require_relative( "../models/vet.rb" )

require("pry-byebug")

def random_tel()
    part_1 = rand(500) + 499
    part_2 = rand(9999)
    return "(0131) #{part_1} #{part_2}"
end

Appointment.delete_all()
Payment.delete_all()
OwnerProduct.delete_all()
Product.delete_all()
PetTreatment.delete_all()
Treatment.delete_all()
Pet.delete_all()
Owner.delete_all()
Vet.delete_all()

vet_1 = Vet.new({
    'first_name' => "Sue",
    'last_name' => "Ollogee",
    'tel' => random_tel(),
    'day_off' => "Wednesday"
})

vet_2 = Vet.new({
    'first_name' => "Annie",
    'last_name' => "Mulcare",
    'tel' => random_tel()
})

vet_3 = Vet.new({
    'first_name' => "Abby",
    'last_name' => "Twah",
    'tel' => random_tel(),
    'day_off' => "Friday"
})

vets = [vet_1, vet_2, vet_3]
vets.each { |vet| vet.save()}

owner_1 = Owner.new({
    'title' => "Mr",
    'first_name' => "Al",
    'last_name' => "Sayshun",
    'addr_1' => "8 Bone Street",
    'addr_2' => "Dogville",
    'town_city' => "Edinburgh",
    'postcode' => "EH16 5AA",
    'email' => "alsayshun@pedigreechum.com",
    'tel' => random_tel()
})
owner_2 = Owner.new({
    'title' => "Ms",
    'first_name' => "Fi",
    'last_name' => "Line",
    'addr_1' => "3 Furball Drive",
    'addr_2' => "Scratchyside",
    'town_city' => "Edinburgh",
    'postcode' => "EH13 6ZZ",
    'email' => "fi.line@purr.com",
    'tel' => random_tel()
})
owner_3 = Owner.new({
    'title' => "Ms",
    'first_name' => "Kat",
    'last_name' => "Luvver",
    'addr_1' => "6 Catnip Place",
    'addr_2' => "Tailton",
    'town_city' => "Edinburgh",
    'postcode' => "EH2 6SS",
    'email' => "kat.luvver@purr.com",
    'tel' => random_tel()
})
owner_4 = Owner.new({
    'title' => "Mr",
    'first_name' => "Pat",
    'last_name' => "Head",
    'addr_1' => "61 Petting Avenue",
    'addr_2' => "Cagely",
    'town_city' => "Edinburgh",
    'postcode' => "EH5 2BB",
    'email' => "pat.head@cage.co.uk",
    'tel' => random_tel()
})

owners = [owner_1, owner_2, owner_3, owner_4]
owners.each { |owner| owner.save()}

pet_1 = Pet.new({
    'name' => "Rover",
    'dob' => "1/4/2015",
    'type' => "dog",
    'notes' => "Has arthritis",
    'owner_id' => owner_1.id
})
pet_2 = Pet.new({
    'name' => "Spot",
    'dob' => "6/6/2013",
    'type' => "dog",
    'notes' => "Bad eyesight",
    'owner_id' => owner_1.id
})
pet_3 = Pet.new({
    'name' => "Tiddles",
    'dob' => "4/1/2017",
    'type' => "cat",
    'notes' => "No tail",
    'owner_id' => owner_2.id
})
pet_4 = Pet.new({
    'name' => "Fluffy",
    'dob' => "3/3/2014",
    'type' => "cat",
    'notes' => "Vicious",
    'owner_id' => owner_2.id
})
pet_5 = Pet.new({
    'name' => "Joey",
    'dob' => "11/11/2019",
    'type' => "budgie",
    'notes' => "Broken wing",
    'owner_id' => owner_2.id
})
pet_6 = Pet.new({
    'name' => "Twiggy",
    'dob' => "5/3/2020",
    'type' => "stick insect",
    'notes' => "Triple heart bypass",
    'owner_id' => owner_2.id
})

pets = [pet_1, pet_2, pet_3, pet_4, pet_5, pet_6]
pets.each { |pet| pet.save() }

treatment_1 = Treatment.new({
    'name' => "Neutering",
    'curr_price' => 49.95
})
treatment_2 = Treatment.new({
    'name' => "Worming",
    'curr_price' => 25.95
})
treatment_3 = Treatment.new({
    'name' => "De-fleaing",
    'curr_price' => 19.95
})
treatment_4 = Treatment.new({
    'name' => "Vaccination",
    'curr_price' => 12.95
})
treatment_5 = Treatment.new({
    'name' => "Transplant",
    'curr_price' => 399.95
})
treatment_6 = Treatment.new({
    'name' => "Claw clipping",
    'curr_price' => 19.95
})

treatments = [treatment_1, treatment_2, treatment_3, treatment_4, treatment_5, treatment_6]
treatments.each { |treatment| treatment.save() }
    
pet_1.assign_to_vet(vet_1.id)
pet_2.assign_to_vet(vet_1.id)
pet_3.assign_to_vet(vet_2.id)
pet_4.assign_to_vet(vet_2.id)
pet_5.assign_to_vet(vet_3.id)
pet_6.assign_to_vet(vet_3.id)
pets.each { |pet| pet.update() }

product_1 = Product.new({
    'name' => "Flea cream",
    'curr_price' => 9.99
})
product_2 = Product.new({
    'name' => "Flea collar",
    'curr_price' => 12.99
})
product_3 = Product.new({
    'name' => "Pet shampoo",
    'curr_price' => 10.99
})
product_4 = Product.new({
    'name' => "Worming tablets",
    'curr_price' => 8.49
})

products = [product_1, product_2, product_3, product_4]
products.each { |product| product.save() }

start_date = Date.new(2020,9,1)
end_date = Date.new(2020,10,1)

for vet in vets
    schedule = Appointment.generate_multiple_schedules(start_date, end_date, vet.id)
    schedule.each { |appointment| appointment.save() }
end

binding.pry
nil
