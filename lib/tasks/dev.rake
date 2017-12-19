namespace :dev do
  task fake: :environment do
    Restaurant.destroy_all

    501.times do |i|
      Restaurant.create!(name: FFaker::NatoAlphabet.alphabetic_code,
      opening_hours: FFaker::Time.datetime,
      tel: FFaker::PhoneNumber.short_phone_number,
      address: FFaker::Address.street_address,
      description: FFaker::Lorem.paragraph,
      category_id: Category.all.sample.id
      #category: Category.all.sample , rails can auto-search too
      )
    end
    puts "have done fake resturants"
    puts "Now you have #{Restaurant.count} restaurant data"
  end
end
