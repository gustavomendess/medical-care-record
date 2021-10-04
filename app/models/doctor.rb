class Doctor < ActiveRecord::Base
  has_many :appointment, dependent: :restrict_with_error

  validates :crm, uniqueness: { scope: :crm_uf }

  validate :attributes_presence

  def attributes_presence
    errors.add(:base, I18n.t('errors.appointments.no_name')) if name.nil?
    errors.add(:base, I18n.t('errors.appointments.no_crm')) if crm.nil?
    errors.add(:base, I18n.t('errors.appointments.no_crm_uf')) if crm_uf.nil?
  end
end
