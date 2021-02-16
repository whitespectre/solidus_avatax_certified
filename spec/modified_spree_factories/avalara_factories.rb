# frozen_string_literal: true

FactoryBot.modify do
  factory :tax_category, class: Spree::TaxCategory do
    name { "TaxCategory - #{rand(999_999)}" }
    tax_code { 'PC030000' }
  end

  factory :address, class: Spree::Address do
    transient do
      country_iso_code { 'US' }
      state_code { 'AL' }
    end

    firstname { 'John' }
    lastname { 'Doe' }
    company { 'Company' }
    address1 { '915 S Jackson St' }
    address2 { '' }
    city { 'Montgomery' }
    state_name { 'Alabama' }
    zipcode { '36104' }
    phone { '555-555-0199' }
    alternative_phone { '555-555-0199' }

    state do |address|
      if !Spree::State.find_by(name: address.state_name).nil?
        Spree::State.find_by(name: address.state_name)
      else
        address.association(:state)
      end
    end

    country do |address|
      if address.state
        address.state.country
      else
        address.association(:country, iso: country_iso_code)
      end
    end
  end

  factory :ship_address, parent: :address do
    address1 { '915 S Jackson St' }
  end
end
