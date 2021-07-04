require 'rails_helper'

RSpec.describe Patient do
  it 'is valid with valid attributes' do
    expect(Patient.new).to_not be_valid
  end
  it 'is not valid without a title'
  it 'is not valid without a description'
  it 'is not valid without a start_date'
  it 'is not valid without a end_date'
end
