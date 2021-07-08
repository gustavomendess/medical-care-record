class Patient < ActiveRecord::Base
  validates_cpf_format_of :cpf, message: 'em formato incorreto'
  validate :cpf_as_integer
  validate :attributes_presence

  def attributes_presence
    errors.add(:base, I18n.t('errors.appointments.no_name')) if name.nil?
    errors.add(:base, I18n.t('errors.appointments.no_birth_date')) if birth_date.nil?
    errors.add(:base, I18n.t('errors.appointments.no_cpf')) if cpf.nil?
  end

  def cpf_as_integer
    return if cpf.nil?

    self.cpf = cpf.gsub(/[^\d]/, '')
    duplicated_cpf = Patient.where(cpf: cpf).exists?
    errors.add(:base, 'Cpf já está em uso') if duplicated_cpf
  end
end
