# Paws & Claws Vet Surgery Project

A simple vet surgery app, built as an individual project as part of the CodeClan (Edinburgh) Professional Software Development Course (Week 5).

The app allows a vet surgery to 
- create a list of vets at the surgery, and create schedules for them
- maintain a list of registered owners and their pets
- maintain an inventory of treatments and products
- manage appointments
- record product sales to owners
- record treatments for pets
- track payments for those treatments and products  

## Getting Started

- Clone the repo and save it to your local computer.
- Create a local database in PostgreSQL and name it vet_surgery.
- Navigate to the repo in your console.
- Run the following, which will populate the db with seed data: 

```
psql -d vet_surgery -f db/vet_surgery.sql
ruby seeds.rb
```
- Visit 'http://localhost:4567/' in your browser.

### Prerequisites

You will need the following ruby gems installed:

- [Sinatra](https://rubygems.org/gems/sinatra/versions/1.4.7)
- [pg](https://rubygems.org/gems/pg)
- [pry-byebug](https://rubygems.org/gems/pry-byebug
)

## Built With

* PostgreSQL - Database
* Ruby/Sinatra - MVC
* HTML/CSS - Front end

## Brief

The project was responding to the following brief:

A veterinary practice has approached you to build a web application to help them manage their animals and vets. A vet may look after many animals at a time. An animal is registered with only one vet.

### MVP

- The practice wants to be able to register / track animals. Important information for the vets to know is -
  - Name
  - Date Of Birth (use a VARCHAR initially)
  - Type of animal
  - Contact details for the owner
  - Treatment notes
- Be able to assign animals to vets
- CRUD actions for vets / animals - remember the user - what would they want to see on each View? What Views should there be?

### Possible Extensions

- Mark owners as being registered/unregistered with the Vet. unregistered owners won't be able to add any more animals.
- If an owner has multiple animals we don't want to keep updating contact details separately for each pet. Extend your application to reflect that an owner can have many pets and to more sensibly keep track of owners' details (avoiding repetition / inconsistencies)
- Handle check-in / check-out dates
- Let the practice see all animals currently in the practice (today's date is between the check-in and check-out?)
- Sometimes an owner does not know the DOB. Allow them to enter an age instead. Try and make sure this always up to date - ie if they visit again a year from now a 3 yr old dog is now 4.
- Add extra functionality of your choosing - assigning treatments, a more comprehensive way of maintaining treatment notes over time. Appointments. Pricing / billing.

## Acknowledgments

* Thanks to CodeClan tutors [Sandy McMillan](https://github.com/waspyfaeleith), [Sky Su](https://github.com/skysu) and [Juan Mata Ruiz](https://github.com/juanmataruiz) and my fellow coursemates who worked on the same project, [Rebeka Geczi](https://github.com/geczirebeka) and [Rudy Zachar](https://github.com/rud-y)
