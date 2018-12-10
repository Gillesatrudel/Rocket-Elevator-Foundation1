require 'rails_helper'

RSpec.describe Address, type: :model do
  it 'is valid if street_ adress and city and state and zip_code and country and address_type and status description fields have value' do
    address = Address.new(street_address: 'test', city: 'test', zip_code: 'test', country: 'test', address_type: 'Billing', status: 'Active')

    expect(address.save).to eq(true)

    #pending "add some examples to (or delete) #{__FILE__}"
  end

  it 'is not valid if it has not street_address' do
    address = Address.new(city: 'test', zip_code: 'test', country: 'test', address_type: 'Billing', status: 'Active')
    validates :street_address, presence: true
    expect(address.save).to eq(true)
  end

  it 'is not valid if it has not city ' do
    address = Address.new(street_address: 'test', zip_code: 'test', country: 'test', address_type: 'Billing', status: 'Active')

    expect(address.save).to be(false)
  end

  it 'is not valid if it has not zip_code' do
    address = Address.new(street_address: 'test', city: 'test', country: 'test', address_type: 'Billing', status: 'Active')
    address.save
    expect(address.errors[:zip_code]).to eq(["can't be blank"])
  end

  it 'is not valid if it has not country' do
    address = Address.new(street_address: 'test', city: 'test', zip_code: 'test', address_type: 'Billing', status: 'Active')
    expect(address.save).to be(false)
  end

  it 'is valid if status has define a status' do
    address = Address.new(street_address: 'test', city: 'test', zip_code: 'test', address_type: 'Billing', status: 'Obsolete')

    expect(address.status).to eq('Active').or eq('Obsolete')
  end
 
  it 'is valid if address_type has a define type' do
    address = Address.new(street_address: 'test', city: 'test', zip_code: 'test', address_type: 'Shipping', status: 'Active')

    expect(address.address_type).to eq('Shipping').or eq('Billing').or eq('Mailling')
  end

  it 'is valid if address_type has a define type' do
    address = Address.new(street_address: 'test', city: 'test', zip_code: 'test', address_type: 'Mailling', status: 'Active')

    expect(address.address_type).to eq('Shipping').or eq('Billing').or eq('Mailling')
  end

end
