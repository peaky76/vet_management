require_relative( "../models/pet.rb" )
require_relative( "../models/vet.rb" )
require("pry-byebug")

Pet.delete_all()
Vet.delete_all()

vet_1 = Vet.new({
    'first_name' => "Sue",
    'last_name' => "Ollogee",
    'tel' => "0131 765 4321"
})

vet_2 = Vet.new({
    'first_name' => "Annie",
    'last_name' => "Mulcare",
    'tel' => "0131 888 2323"
})

vet_3 = Vet.new({
    'first_name' => "Abby",
    'last_name' => "Twah",
    'tel' => "0131 765 4321"
})

vets = [vet_1, vet_2, vet_3]
vets.each { |vet| vet.save()}

pet_1 = Pet.new({
    'name' => "Rover",
    'dob' => "1/4/2015",
    'type' => "dog",
    'owner_tel' => "0131 123 4567",
    'notes' => "Has arthritis",
    'vet_id' => vet_1.id
})

pet_2 = Pet.new({
    'name' => "Tiddles",
    'dob' => "4/1/2017",
    'type' => "cat",
    'owner_tel' => "0131 321 7654",
    'notes' => "No tail",
    'vet_id' => vet_2.id
})

pet_3 = Pet.new({
    'name' => "Joey",
    'dob' => "11/11/2019",
    'type' => "budgie",
    'owner_tel' => "0131 333 4444",
    'notes' => "Broken wing",
    'vet_id' => vet_2.id
})

pet_4 = Pet.new({
    'name' => "Twiggy",
    'dob' => "5/3/2020",
    'type' => "stick insect",
    'owner_tel' => "0131 123 7777",
    'notes' => "Triple heart bypass",
    'vet_id' => vet_1.id
})

pets = [pet_1, pet_2, pet_3, pet_4]
pets.each { |pet| pet.save() }

binding.pry
nil
