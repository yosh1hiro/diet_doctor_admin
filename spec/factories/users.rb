# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "ユーザ-#{n}" }
    password_digest BCrypt::Password.create('hoge')

    after(:create) do |user|
      create(:register_event, user: user)
      create(:connect_event, user: user)
      create(:dd_clinic_event, user: user)
      create(:connect_event, user: user)
      create(:counsel_event, user: user)
      create(:connect_event, user: user)
      create(:pro_edition_event, user: user)
    end
  end
end
