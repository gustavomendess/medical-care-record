RSpec.describe Doctor do
  subject {
    described_class.new(name: 'Dr William mendes',
                        crm: '19210',
                        crm_uf: 'SC')
  }
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a crm' do
    subject.crm = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a crm_uf' do
    subject.crm_uf = nil
    expect(subject).to_not be_valid
  end
end
