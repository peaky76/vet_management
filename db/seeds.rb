require_relative( "../models/payment.rb" )
require_relative( "../models/pet_treatment.rb" )
require_relative( "../models/treatment.rb" )
require_relative( "../models/pet.rb" )
require_relative( "../models/owner.rb" )
require_relative( "../models/vet.rb" )
require_relative( "../models/timeslot.rb" )
require_relative( "../models/surgery.rb" )
require("pry-byebug")

def random_tel()
    part_1 = rand(500) + 499
    part_2 = rand(9999)
    return "(0131) #{part_1} #{part_2}"
end

Payment.delete_all()
PetTreatment.delete_all()
Treatment.delete_all()
Pet.delete_all()
Owner.delete_all()
Vet.delete_all()

vet_1 = Vet.new({
    'first_name' => "Sue",
    'last_name' => "Ollogee",
    'tel' => random_tel()
})

vet_2 = Vet.new({
    'first_name' => "Annie",
    'last_name' => "Mulcare",
    'tel' => random_tel()
})

vet_3 = Vet.new({
    'first_name' => "Abby",
    'last_name' => "Twah",
    'tel' => random_tel()
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
    'first_name' => "Leigh",
    'last_name' => "Murr",
    'addr_1' => "8 Forest Street",
    'addr_2' => "Wildtown",
    'town_city' => "Edinburgh",
    'postcode' => "EH13 6ZZ",
    'email' => "leighmurr@intheforest.com",
    'tel' => random_tel()
})
owner_3 = Owner.new({
    'title' => "Col",
    'first_name' => "Harland",
    'last_name' => "Sanders",
    'addr_1' => "12 Kentucky Road",
    'addr_2' => "Fryville",
    'town_city' => "Edinburgh",
    'postcode' => "EH3 6KK",
    'email' => "colonel@kfc.com",
    'tel' => random_tel()
})

owners = [owner_1, owner_2, owner_3]
owners.each { |owner| owner.save()}

pet_1 = Pet.new({
    'name' => "Rover",
    'dob' => "1/4/2015",
    'type' => "dog",
    'notes' => "Has arthritis",
    'owner_id' => owner_1.id
})

pet_2 = Pet.new({
    'name' => "Tiddles",
    'dob' => "4/1/2017",
    'type' => "cat",
    'notes' => "No tail",
    'owner_id' => owner_1.id
})

pet_3 = Pet.new({
    'name' => "Joey",
    'dob' => "11/11/2019",
    'type' => "budgie",
    'notes' => "Broken wing",
    'owner_id' => owner_2.id
})

pet_4 = Pet.new({
    'name' => "Twiggy",
    'dob' => "5/3/2020",
    'type' => "stick insect",
    'notes' => "Triple heart bypass",
    'owner_id' => owner_2.id
})

pets = [pet_1, pet_2, pet_3, pet_4]
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
    'curr_price' => 14.95
})

treatments = [treatment_1, treatment_2, treatment_3]
treatments.each { |treatment| treatment.save() }

pet_treatment_1 = PetTreatment.new({
    'pet_id' => pet_1.id,
    'treatment_id' => treatment_1.id,
    'date' => "1/7/2020"
})
pet_treatment_2 = PetTreatment.new({
    'pet_id' => pet_4.id,
    'treatment_id' => treatment_1.id,
    'date' => "6/6/2020"
})
pet_treatment_3 = PetTreatment.new({
    'pet_id' => pet_1.id,
    'treatment_id' => treatment_2.id,
    'date' => "14/3/2020"
})
    
pet_treatments = [pet_treatment_1, pet_treatment_2, pet_treatment_3]
pet_treatments.each { |pet_treatment| pet_treatment.save() }

pet_1.assign_to_vet(vet_1.id)
pet_2.assign_to_vet(vet_1.id)
pet_3.assign_to_vet(vet_2.id)
pet_4.assign_to_vet(vet_2.id)
pets.each { |pet| pet.update() }

payment_1 = Payment.new({
    'owner_id' => owner_1.id,
    'amount' => 50.00,
    'date' => "11/7/2020"
})
payment_1.save()

payment_2 = Payment.new({
    'owner_id' => owner_1.id,
    'amount' => 20.00,
    'date' => "12/7/2020"
})
payment_2.save()

appointments = Timeslot.generate(Time.now(), vet_1.id)

binding.pry
nil
