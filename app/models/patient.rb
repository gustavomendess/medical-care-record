class Patient < ActiveRecord::Base
  validates_cpf_format_of :cpf, message: 'em formato incorreto'
  validate :cpf_as_integer
  validate :attributes_presence

  def attributes_presence
    errors.add(:base, I18n.t('errors.appointments.no_name')) if name.empty?
    errors.add(:base, I18n.t('errors.appointments.no_birth_date')) if birth_date.nil?
    errors.add(:base, I18n.t('errors.appointments.no_cpf')) if cpf.nil?
  end

  def cpf_as_integer
    self.cpf = cpf.gsub(/[^\d]/, '')
    if Patient.where(cpf: cpf).exists?
      errors[:base] << 'Cpf já está em uso'
    end
  end
end
