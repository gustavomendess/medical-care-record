class Doctor < ActiveRecord::Base
  has_many :appointment, dependent: :restrict_with_error

  validate :attributes_presence
  validate :duplicated_doctor

  def attributes_presence
    errors.add(:base, I18n.t('errors.appointments.no_name')) if name.nil?
    errors.add(:base, I18n.t('errors.appointments.no_crm')) if crm.nil?
    errors.add(:base, I18n.t('errors.appointments.no_crm_uf')) if crm_uf.nil?
  end

  def duplicated_doctor
    return unless new_record?

    duplicated = Doctor.where(crm: crm, crm_uf: crm_uf).exists?
    errors.add(:base, "O CRM (#{crm} - #{crm_uf}) já está em uso") if duplicated
  end
end
