require 'rails_helper'

Rspec.describe Address, type: :model do
  it 'is valid if street_ adress and city and state and zip_code description fields have value' do
    name = Name.new(street_adress: 'test', city: 'test', state: 'test', zip_code: 'test', country: 'test')

    expect(adress.save).to eq(true)

    #pending "add some examples to (or delete) #{__FILE__}"
  end
end
