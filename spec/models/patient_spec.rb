RSpec.describe Patient do
  subject {
    described_class.new(name: 'Gustavo',
                        birth_date: '06/08/1995',
                        cpf: '096.651.629-00')
  }
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a birth_date' do
    subject.birth_date = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a cpf' do
    subject.cpf = nil
    expect(subject).to_not be_valid
  end
end
