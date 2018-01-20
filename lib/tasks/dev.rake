namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    101.times do |i|
      Restaurant.create!(name: FFaker::NatoAlphabet.alphabetic_code,
      opening_hours: FFaker::Time.datetime,
      tel: FFaker::PhoneNumber.short_phone_number,
      address: FFaker::Address.street_address,
      description: FFaker::Lorem.paragraph,
      category_id: Category.all.sample.id,
      #category: Category.all.sample , rails can auto-search too
      image: File.open(File.join(Rails.root,"/public/img/model#{rand(1..10)}.jpg"))
      )
    end
    puts "have done fake resturants"
    puts "Now you have #{Restaurant.count} restaurant data"
  end

  task fake_user: :environment do
    Comment.destroy_all #so it can be destroyed without concerns of realtionship settings
    User.where(role: nil).destroy_all
    20.times do |i|
    User.create!(
    name: FFaker::Name.name,
    email: FFaker::InternetSE.free_email,
    password: "12345678",
    avatar: File.open(File.join(Rails.root,"/public/img/avatar.png"))
    )
    end
    puts "Now you have #{User.count} user data"
  end

  task fake_comment: :environment do
    Comment.destroy_all
    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(content: FFaker::Lorem.sentence,
        user_id: User.all.sample.id
        )
      end
    end
    puts "have done fake comments"
    puts "Now you have #{Comment.count} comment data"
  end

  task fake_favorite: :environment do
    Favorite.destroy_all
    User.all.each do |u|
     20.times do
       u.favorites.create!(
        restaurant: Restaurant.all.sample,
       )
     end
    end
    puts "now you have fake #{Favorite.count} favorited restaurants"
  end

  task fake_like: :environment do
    Like.destroy_all
    User.all.each do |u|
     5.times do
       u.likes.create!(
        restaurant: Restaurant.all.sample,
       )
     end
    end
    puts "now you have #{Like.count} liked restaurants"
  end
end
