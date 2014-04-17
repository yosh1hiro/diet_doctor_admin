# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:occur) { |n| Date.new(2000, 1, 1) + n }

  factory :register_event, class: Event do
    occur
    event_code Event::REGISTER
    value 1
  end

  factory :connect_event, class: Event do
    occur
    event_code Event::CONNECT
    value 1
  end

  factory :counsel_event, class: Event do
    occur
    event_code Event::COUNSEL
    value 1
  end

  factory :dd_clinic_event, class: Event do
    occur
    event_code Event::DD_CLINIC
    value 500
  end

  factory :pro_edition_event, class: Event do
    occur
    event_code Event::PRO_EDITION
    value 800
  end
end
