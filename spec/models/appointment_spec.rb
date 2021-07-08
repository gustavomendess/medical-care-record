RSpec.describe Appointment do
  subject {
    described_class.new(appointment_date: '06/07/2021',
                        starts_at: '09:30',
                        ends_at: '10:00',
                        doctor_id: 1,
                        patient_id: 2,
                        appointment_description: 'teste covid-19')
  }

  it 'Associations' do
    should belong_to(:patient)
    should belong_to(:doctor)
  end
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is valid without a appointment_description' do
    subject.appointment_description = nil
    expect(subject).to be_valid
  end
  it 'is not valid without a starts_at' do
    subject.starts_at = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a ends_at' do
    subject.ends_at = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a ends_at' do
    subject.ends_at = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a appointment_date' do
    subject.appointment_date = nil
    expect(subject).to_not be_valid
  end
end
